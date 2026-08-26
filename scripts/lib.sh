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

emit_category_rules() {
    local category=$1

    case "$category" in
        proxy)
            collect_rules "${BASE_FOLDER}/base/domains" proxy | awk '{print "||" $0}'
            collect_rules "${BASE_FOLDER}/base/domain" proxy
            collect_rules "${BASE_FOLDER}/base/domain_keywords" proxy | awk '{print "||*" $0 "*"}'
            ;;
        local)
            collect_rules "${BASE_FOLDER}/base/domains" local | awk '{print "||" $0}'
            collect_rules "${BASE_FOLDER}/base/domain" local
            ;;
        reject)
            collect_rules "${BASE_FOLDER}/base/domains" reject | awk '{print "||" $0}'
            collect_rules "${BASE_FOLDER}/base/domain" reject
            ;;
        wg)
            collect_rules "${BASE_FOLDER}/base/domains" wg | awk '{print "||" $0}'
            collect_rules "${BASE_FOLDER}/base/domain" wg
            collect_rules "${BASE_FOLDER}/base/domain_keywords" wg | awk '{print "||*" $0 "*"}'
            ;;
        wk)
            collect_rules "${BASE_FOLDER}/base/domains" wk | awk '{print "||" $0}'
            collect_rules "${BASE_FOLDER}/base/domain" wk
            collect_rules "${BASE_FOLDER}/base/domain_keywords" wk | awk '{print "||*" $0 "*"}'
            ;;
        *)
            printf 'unknown rule category: %s\n' "$category" >&2
            return 2
            ;;
    esac
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
