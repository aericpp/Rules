#!/bin/bash

BASE_FOLDER=$(cd "$(dirname "$0")/..";pwd)
echo "${BASE_FOLDER}"

rm -rf ${BASE_FOLDER}/autoproxy
rm -rf ${BASE_FOLDER}/v
rm -rf ${BASE_FOLDER}/shadowrocket
rm -rf ${BASE_FOLDER}/surge