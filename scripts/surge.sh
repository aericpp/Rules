#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=lib.sh
source "${SCRIPT_DIR}/lib.sh"

OUTPUT_DIR="${BASE_FOLDER}/surge"
prepare_output_dir "$OUTPUT_DIR"

categories=$(list_categories proxy local direct reject wg wk)
while IFS= read -r category; do
    emit_client_rules "$category" true | write_atomic_output "${OUTPUT_DIR}/${category}.list"
done <<< "$categories"
