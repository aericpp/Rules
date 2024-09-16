#!/bin/bash
set -eu

sudo apt update
sudo apt install -qy git

CURRENT_PATH=$(pwd)

git clone https://github.com/v2fly/domain-list-community.git
cd "${CURRENT_PATH}/domain-list-community"
go mod download
go run ./ --datapath="${CURRENT_PATH}/v"

test -d "${CURRENT_PATH}/release" || mkdir "${CURRENT_PATH}/release"
cp "${CURRENT_PATH}/domain-list-community/dlc.dat" "${CURRENT_PATH}/release/"

cd "${CURRENT_PATH}"
tar cvzf "${CURRENT_PATH}/release/surge.tar.gz" surge
tar cvzf "${CURRENT_PATH}/release/autoproxy.tar.gz" autoproxy
tar cvzf "${CURRENT_PATH}/release/shadowrocket.tar.gz" shadowrocket

cp -R "${CURRENT_PATH}/surge" "${CURRENT_PATH}/release/"
cp -R "${CURRENT_PATH}/autoproxy" "${CURRENT_PATH}/release/"
cp -R "${CURRENT_PATH}/shadowrocket" "${CURRENT_PATH}/release/"

ls -alh "${CURRENT_PATH}/"

ls -alh "${CURRENT_PATH}/release/"

