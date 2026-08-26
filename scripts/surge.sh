#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=lib.sh
source "${SCRIPT_DIR}/lib.sh"

OUTPUT_DIR="${BASE_FOLDER}/surge"
prepare_output_dir "$OUTPUT_DIR"

{
    collect_rules "${BASE_FOLDER}/base/process" local | awk '{print "PROCESS-NAME," $0}'
    collect_rules "${BASE_FOLDER}/base/domains" local | awk '{print "DOMAIN-SUFFIX," $0}'
    collect_rules "${BASE_FOLDER}/base/domain" local | awk '{print "DOMAIN," $0}'
    collect_rules "${BASE_FOLDER}/base/cidr" local | awk '{print "IP-CIDR," $0 ",no-resolve"}'
} | write_atomic_output "${OUTPUT_DIR}/local.list"

{
    collect_rules "${BASE_FOLDER}/base/process" proxy | awk '{print "PROCESS-NAME," $0}'
    collect_rules "${BASE_FOLDER}/base/domains" proxy | awk '{print "DOMAIN-SUFFIX," $0}'
    collect_rules "${BASE_FOLDER}/base/domain" proxy | awk '{print "DOMAIN," $0}'
    collect_rules "${BASE_FOLDER}/base/domain_keywords" proxy | awk '{print "DOMAIN-KEYWORD," $0}'
    collect_rules "${BASE_FOLDER}/base/cidr" proxy | awk '{print "IP-CIDR," $0 ",no-resolve"}'
} | write_atomic_output "${OUTPUT_DIR}/proxy.list"

{
    collect_rules "${BASE_FOLDER}/base/process" direct | awk '{print "PROCESS-NAME," $0}'
    collect_rules "${BASE_FOLDER}/base/domains" direct | awk '{print "DOMAIN-SUFFIX," $0}'
    collect_rules "${BASE_FOLDER}/base/domain" direct | awk '{print "DOMAIN," $0}'
} | write_atomic_output "${OUTPUT_DIR}/direct.list"

{
    collect_rules "${BASE_FOLDER}/base/domains" reject | awk '{print "DOMAIN-SUFFIX," $0}'
    collect_rules "${BASE_FOLDER}/base/domain" reject | awk '{print "DOMAIN," $0}'
} | write_atomic_output "${OUTPUT_DIR}/reject.list"

{
    collect_rules "${BASE_FOLDER}/base/domains" wg | awk '{print "DOMAIN-SUFFIX," $0}'
    collect_rules "${BASE_FOLDER}/base/domain" wg | awk '{print "DOMAIN," $0}'
    collect_rules "${BASE_FOLDER}/base/domain_keywords" wg | awk '{print "DOMAIN-KEYWORD," $0}'
    collect_rules "${BASE_FOLDER}/base/cidr" wg | awk '{print "IP-CIDR," $0 ",no-resolve"}'
} | write_atomic_output "${OUTPUT_DIR}/wg.list"

{
    collect_rules "${BASE_FOLDER}/base/domains" wk | awk '{print "DOMAIN-SUFFIX," $0}'
    collect_rules "${BASE_FOLDER}/base/domain" wk | awk '{print "DOMAIN," $0}'
    collect_rules "${BASE_FOLDER}/base/domain_keywords" wk | awk '{print "DOMAIN-KEYWORD," $0}'
    collect_rules "${BASE_FOLDER}/base/cidr" wk | awk '{print "IP-CIDR," $0 ",no-resolve"}'
} | write_atomic_output "${OUTPUT_DIR}/wk.list"
