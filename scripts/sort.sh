#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=lib.sh
source "${SCRIPT_DIR}/lib.sh"

check=false
if [[ ${1:-} == "--check" ]]; then
    check=true
elif [[ ${1:-} == "--fix" ]]; then
    check=false
elif [[ $# -gt 0 ]]; then
    printf 'usage: %s [--check|--fix]\n' "$0" >&2
    exit 2
fi

failed=false

while IFS= read -r -d '' file; do
    # NUL bytes can occur in non-text files under base; sort would corrupt them.
    if ! LC_ALL=C tr -d '\000' < "$file" | cmp -s - "$file"; then
        continue
    fi

    if "$check"; then
        if ! sort -c "$file" >/dev/null 2>&1; then
            printf 'unsorted source file: %s\n' "$file" >&2
            failed=true
        fi
    else
        sort -u "$file" -o "$file"
    fi
done < <(find "${BASE_FOLDER}/base" -type f -print0)

if "$failed"; then
    exit 1
fi

if "$check"; then
    printf 'source rules are sorted\n'
else
    printf 'source rules sorted\n'
fi
