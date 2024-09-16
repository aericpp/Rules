#!/bin/bash
set -eu

sudo apt update
sudo apt install -qy git

CURRENT_PATH=$(pwd)

# cd /root

git clone https://github.com/aericpp/Rules.git
git clone https://github.com/v2fly/domain-list-community.git
cd "${CURRENT_PATH}/domain-list-community"
go mod download
go run ./ --datapath="${CURRENT_PATH}/Rules/v"

test -d "${CURRENT_PATH}/release" || mkdir "${CURRENT_PATH}/release"
cp "${CURRENT_PATH}/domain-list-community/dlc.dat" "${CURRENT_PATH}/release/"

cd "${CURRENT_PATH}/Rules/"
tar cvzf "${CURRENT_PATH}/release/surge.tar.gz" surge
tar cvzf "${CURRENT_PATH}/release/autoproxy.tar.gz" autoproxy
tar cvzf "${CURRENT_PATH}/release/shadowrocket.tar.gz" shadowrocket

cp -R "${CURRENT_PATH}/Rules/surge" "${CURRENT_PATH}/release/"
cp -R "${CURRENT_PATH}/Rules/autoproxy" "${CURRENT_PATH}/release/"
cp -R "${CURRENT_PATH}/Rules/shadowrocket" "${CURRENT_PATH}/release/"

ls -alh "${CURRENT_PATH}/Rules/"

ls -alh "${CURRENT_PATH}/release/"

