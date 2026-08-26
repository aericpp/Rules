#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=lib.sh
source "${SCRIPT_DIR}/lib.sh"

OUTPUT_DIR="${BASE_FOLDER}/autoproxy"
prepare_output_dir "$OUTPUT_DIR"

for category in proxy local reject wg wk; do
    raw_file="${OUTPUT_DIR}/${category}_raw.list"
    {
        printf '[AutoProxy]\n'
        emit_category_rules "$category"
    } | write_atomic_output "$raw_file"

    encode_base64_wrapped "$raw_file" > "${OUTPUT_DIR}/${category}.list"
done
