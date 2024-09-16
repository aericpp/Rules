#!/bin/bash

BASE_FOLDER=$(cd "$(dirname "$0")/..";pwd)
echo "${BASE_FOLDER}"
for dir_path in ${BASE_FOLDER}/base/*; do
    if test -f $dir_path; then
        continue
    fi
    for file in ${dir_path}/*; do
        cat ${file} | sort | uniq >${dir_path}/tmp.file
        cat ${dir_path}/tmp.file >${file}
    done
    rm -f ${dir_path}/tmp.file
done