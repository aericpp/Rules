#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=lib.sh
source "${SCRIPT_DIR}/lib.sh"

for directory in autoproxy raw release shadowrocket surge v domain-list-community geoip; do
    rm -rf "${BASE_FOLDER}/${directory}"
done

printf 'generated files removed\n'
