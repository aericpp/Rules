#!/bin/bash
set -eu

sudo apt update
sudo apt install -qy build-essential libpcre3-dev zlib1g-dev git

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
tar cvzf surge.tar.gz surge
tar cvzf autoproxy.tar.gz autoproxy
tar cvzf shadowrocket.tar.gz shadowrocket

cp "${CURRENT_PATH}/Rules/*.tar.gz" "${CURRENT_PATH}/release/"
