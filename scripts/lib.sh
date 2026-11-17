#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
BASE_FOLDER=$(cd "${SCRIPT_DIR}/.." && pwd)
export LC_ALL=C

collect_rules() {
    local directory=$1
    local suffix=$2

    find "$directory" -maxdepth 1 -type f -name "*.${suffix}" -exec awk '
        {
            line = $0
            sub(/\r$/, "", line)
            sub(/^[[:space:]]+/, "", line)
            sub(/[[:space:]]+$/, "", line)
            if (line != "" && line !~ /^#/) {
                print line
            }
        }
    ' {} + | sort -u
}

list_categories() {
    {
        printf '%s\n' "$@"
        find "${BASE_FOLDER}/base/"{domains,domain,domain_keywords,cidr,process} \
            -maxdepth 1 -type f -name '*.*' ! -name '.*' -print \
            | awk -F. '$NF ~ /^[a-z0-9_-]+$/ {print $NF}'
    } | sort -u
}

emit_category_rules() {
    local category=$1

    collect_rules "${BASE_FOLDER}/base/domains" "$category" | awk '{print "||" $0}'
    collect_rules "${BASE_FOLDER}/base/domain" "$category"
    collect_rules "${BASE_FOLDER}/base/domain_keywords" "$category" | awk '{print "||*" $0 "*"}'
}

emit_client_rules() {
    local category=$1
    local include_process=$2

    if [[ "$include_process" == true ]]; then
        collect_rules "${BASE_FOLDER}/base/process" "$category" | awk '{print "PROCESS-NAME," $0}'
    fi
    collect_rules "${BASE_FOLDER}/base/domains" "$category" | awk '{print "DOMAIN-SUFFIX," $0}'
    collect_rules "${BASE_FOLDER}/base/domain" "$category" | awk '{print "DOMAIN," $0}'
    collect_rules "${BASE_FOLDER}/base/domain_keywords" "$category" | awk '{print "DOMAIN-KEYWORD," $0}'
    collect_rules "${BASE_FOLDER}/base/cidr" "$category" | awk '{print "IP-CIDR," $0 ",no-resolve"}'
}

prepare_output_dir() {
    local directory=$1

    rm -rf "$directory"
    mkdir -p "$directory"
}

write_atomic_output() {
    local output=$1
    local temporary

    temporary=$(mktemp "${output}.tmp.XXXXXX")
    cat > "$temporary"
    mv "$temporary" "$output"
}

encode_base64_wrapped() {
    local input=$1

    if base64 -w 0 < /dev/null > /dev/null 2>&1; then
        base64 -w 0 < "$input"
    else
        base64 < "$input" | tr -d '\n'
    fi | fold -w 64
}
