#!/usr/bin/env bash

set -euo pipefail

CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
SCRIPT_DIR="${CURRENT_PATH}/scripts"
BUILD_DIR=$(mktemp -d)
RELEASE_DIR="${BUILD_DIR}/release"

cleanup() {
    rm -rf "$BUILD_DIR"
}
trap cleanup EXIT

umask 022

bash "${SCRIPT_DIR}/validate.sh"
bash "${SCRIPT_DIR}/surge.sh"
bash "${SCRIPT_DIR}/shadowrocket.sh"
bash "${SCRIPT_DIR}/autoproxy.sh"
bash "${SCRIPT_DIR}/raw.sh"
bash "${SCRIPT_DIR}/v.sh"

git clone --depth 1 https://github.com/v2fly/domain-list-community.git \
    "${BUILD_DIR}/domain-list-community"
(
    cd "${BUILD_DIR}/domain-list-community"
    go mod download
    go run ./ --datapath="${CURRENT_PATH}/v"
)

git clone --depth 1 https://github.com/v2fly/geoip.git "${BUILD_DIR}/geoip"
(
    cd "${BUILD_DIR}/geoip"
    go mod download
    mkdir -p cidr
    source "${SCRIPT_DIR}/lib.sh"
    collect_rules "${CURRENT_PATH}/base/cidr" proxy > cidr/proxy
    cp "${CURRENT_PATH}/geoip_config.json" geoip_config.json
    go run ./ -c ./geoip_config.json
)

mkdir -p "$RELEASE_DIR"
cp "${BUILD_DIR}/domain-list-community/dlc.dat" "$RELEASE_DIR/"
cp "${BUILD_DIR}/geoip/output/geoip.dat" "$RELEASE_DIR/"

for directory in surge autoproxy shadowrocket raw; do
    tar -czf "${RELEASE_DIR}/${directory}.tar.gz" -C "$CURRENT_PATH" "$directory"
    cp -R "${CURRENT_PATH}/${directory}" "$RELEASE_DIR/"

    for file in "${CURRENT_PATH}/${directory}"/*; do
        [[ -f "$file" ]] || continue
        cp "$file" "${RELEASE_DIR}/${directory}_$(basename "$file")"
    done
done

rm -rf "${CURRENT_PATH}/release"
mv "$RELEASE_DIR" "${CURRENT_PATH}/release"

printf 'release generated at %s\n' "${CURRENT_PATH}/release"
