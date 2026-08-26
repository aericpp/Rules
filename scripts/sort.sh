#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=lib.sh
source "${SCRIPT_DIR}/lib.sh"

fix=false
if [[ ${1:-} == "--fix" ]]; then
    fix=true
elif [[ $# -gt 0 ]]; then
    printf 'usage: %s [--fix]\n' "$0" >&2
    exit 2
fi

while IFS= read -r -d '' file; do
    if "$fix"; then
        sort -u "$file" -o "$file"
    else
        sort -c "$file" >/dev/null
    fi
done < <(find "${BASE_FOLDER}/base" -type f -print0)

if "$fix"; then
    printf 'source rules sorted\n'
else
    printf 'source rules are sorted\n'
fi
