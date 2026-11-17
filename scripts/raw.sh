#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=lib.sh
source "${SCRIPT_DIR}/lib.sh"

OUTPUT_DIR="${BASE_FOLDER}/raw"
prepare_output_dir "$OUTPUT_DIR"

categories=$(list_categories proxy local reject wg wk)
while IFS= read -r category; do
    {
        printf '# raw list\n'
        emit_category_rules "$category"
    } | write_atomic_output "${OUTPUT_DIR}/${category}.list"
done <<< "$categories"
