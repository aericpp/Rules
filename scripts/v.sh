#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=lib.sh
source "${SCRIPT_DIR}/lib.sh"

OUTPUT_DIR="${BASE_FOLDER}/v"
prepare_output_dir "$OUTPUT_DIR"

{
    collect_rules "${BASE_FOLDER}/base/domains" proxy | awk '{print "domain:" $0}'
    collect_rules "${BASE_FOLDER}/base/domain" proxy | awk '{print "full:" $0}'
    collect_rules "${BASE_FOLDER}/base/domain_keywords" proxy | awk '{print "keyword:" $0}'
} | write_atomic_output "${OUTPUT_DIR}/proxy"

{
    collect_rules "${BASE_FOLDER}/base/domains" local | awk '{print "domain:" $0}'
    collect_rules "${BASE_FOLDER}/base/domain" local | awk '{print "full:" $0}'
} | write_atomic_output "${OUTPUT_DIR}/local"

{
    collect_rules "${BASE_FOLDER}/base/domains" reject | awk '{print "domain:" $0}'
    collect_rules "${BASE_FOLDER}/base/domain" reject | awk '{print "full:" $0}'
} | write_atomic_output "${OUTPUT_DIR}/reject"

{
    collect_rules "${BASE_FOLDER}/base/domains" wg | awk '{print "domain:" $0}'
    collect_rules "${BASE_FOLDER}/base/domain" wg | awk '{print "full:" $0}'
    collect_rules "${BASE_FOLDER}/base/domain_keywords" wg | awk '{print "keyword:" $0}'
} | write_atomic_output "${OUTPUT_DIR}/wg"
