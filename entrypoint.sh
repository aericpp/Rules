#!/bin/bash
set -eu

sudo apt update
sudo apt install -qy git

CURRENT_PATH=$(pwd)

# 
test -d "${CURRENT_PATH}/v" || mkdir "${CURRENT_PATH}/v"
test -d "${CURRENT_PATH}/surge" || mkdir "${CURRENT_PATH}/surge"
test -d "${CURRENT_PATH}/shadowrocket" || mkdir "${CURRENT_PATH}/shadowrocket"
test -d "${CURRENT_PATH}/autoproxy" || mkdir "${CURRENT_PATH}/autoproxy"

# 
bash scripts/sort.sh
bash scripts/surge.sh
bash scripts/shadowrocket.sh
bash scripts/autoproxy.sh
bash scripts/v.sh

# compile the geosite.dat file
git clone https://github.com/v2fly/domain-list-community.git
cd "${CURRENT_PATH}/domain-list-community"
go mod download
go run ./ --datapath="${CURRENT_PATH}/v"

# handle the release files
test -d "${CURRENT_PATH}/release" || mkdir "${CURRENT_PATH}/release"
cp "${CURRENT_PATH}/domain-list-community/dlc.dat" "${CURRENT_PATH}/release/"

cd "${CURRENT_PATH}"
tar cvzf "${CURRENT_PATH}/release/surge.tar.gz" surge
tar cvzf "${CURRENT_PATH}/release/autoproxy.tar.gz" autoproxy
tar cvzf "${CURRENT_PATH}/release/shadowrocket.tar.gz" shadowrocket

cp -R "${CURRENT_PATH}/surge" "${CURRENT_PATH}/release/"
cp -R "${CURRENT_PATH}/autoproxy" "${CURRENT_PATH}/release/"
cp -R "${CURRENT_PATH}/shadowrocket" "${CURRENT_PATH}/release/"

cd "${CURRENT_PATH}"
for file in surge/*; do
  cp $file "release/${file//\//_}"
done

for file in autoproxy/*; do
  cp $file "release/${file//\//_}"
done


for file in shadowrocket/*; do
  cp $file "release/${file//\//_}"
done