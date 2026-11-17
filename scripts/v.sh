#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=lib.sh
source "${SCRIPT_DIR}/lib.sh"

OUTPUT_DIR="${BASE_FOLDER}/v"
prepare_output_dir "$OUTPUT_DIR"

categories=$(list_categories proxy local reject wg)
while IFS= read -r category; do
    {
        collect_rules "${BASE_FOLDER}/base/domains" "$category" | awk '{print "domain:" $0}'
        collect_rules "${BASE_FOLDER}/base/domain" "$category" | awk '{print "full:" $0}'
        collect_rules "${BASE_FOLDER}/base/domain_keywords" "$category" | awk '{print "keyword:" $0}'
    } | write_atomic_output "${OUTPUT_DIR}/${category}"
done <<< "$categories"
