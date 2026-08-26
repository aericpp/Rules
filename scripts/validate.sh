#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=lib.sh
source "${SCRIPT_DIR}/lib.sh"

failed=false

while IFS= read -r -d '' file; do
    if ! sort -c "$file" >/dev/null 2>&1; then
        printf 'unsorted source file: %s\n' "$file" >&2
        failed=true
    fi

    case "$file" in
        "${BASE_FOLDER}/base/domains"/*|"${BASE_FOLDER}/base/domain"/*|"${BASE_FOLDER}/base/domain_keywords"/*|"${BASE_FOLDER}/base/cidr"/*)
            if awk '/^[[:space:]]|[[:space:]]$|\r$/ { exit 1 }' "$file"; then
                :
            else
                printf 'whitespace or CRLF in rule file: %s\n' "$file" >&2
                failed=true
            fi
            ;;
    esac
done < <(find "${BASE_FOLDER}/base" -type f -print0)

for directory in domains domain domain_keywords cidr process; do
    while IFS= read -r duplicate; do
        [[ -n "$duplicate" ]] || continue
        printf 'duplicate source entry in %s: %s\n' "$directory" "$duplicate" >&2
        failed=true
    done < <(
        find "${BASE_FOLDER}/base/${directory}" -maxdepth 1 -type f -exec awk 'NF { print }' {} + \
            | sort | uniq -d
    )
done

while IFS= read -r file; do
    while IFS= read -r rule; do
        [[ -n "$rule" ]] || continue
        if ! awk -v value="$rule" '
            BEGIN {
                count = split(value, parts, "/")
                octet_count = split(parts[1], octets, ".")
                valid = (count == 2 && octet_count == 4 && parts[2] ~ /^[0-9]+$/ && parts[2] <= 32)
                for (i = 1; i <= 4; i++) {
                    valid = valid && octets[i] ~ /^[0-9]+$/ && octets[i] <= 255
                }
                exit(valid ? 0 : 1)
            }
        '; then
            printf 'invalid IPv4 CIDR: %s:%s\n' "$file" "$rule" >&2
            failed=true
        fi
    done < "$file"
done < <(find "${BASE_FOLDER}/base/cidr" -maxdepth 1 -type f -print)

if "$failed"; then
    exit 1
fi

printf 'rule validation passed\n'
