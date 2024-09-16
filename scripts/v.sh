#!/bin/bash

BASE_FOLDER=$(cd "$(dirname "$0")/..";pwd)
echo $BASE_FOLDER

test -d "${BASE_FOLDER}/v" || mkdir "${BASE_FOLDER}/v"
rm -f ${BASE_FOLDER}/v/*

echo "# proxy file" >"${BASE_FOLDER}/v/proxy"
echo "# direct file" >"${BASE_FOLDER}/v/local"
echo "# reject file" >"${BASE_FOLDER}/v/reject"
echo "# direct file" >"${BASE_FOLDER}/v/wg"


# Domain-suffix lists
cat ${BASE_FOLDER}/base/domains/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "domain:"$0}' >>"${BASE_FOLDER}/v/proxy"


cat ${BASE_FOLDER}/base/domains/*.wg 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "domain:"$0}' >>"${BASE_FOLDER}/v/wg"

cat ${BASE_FOLDER}/base/domains/*.local 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "domain:"$0}' >>"${BASE_FOLDER}/v/local"

cat ${BASE_FOLDER}/base/domains/*.reject 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "domain:"$0}' >>"${BASE_FOLDER}/v/reject"

cat ${BASE_FOLDER}/base/domains/*.gia 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "domain:"$0}' >>"${BASE_FOLDER}/v/proxy"

# Domain lists

cat ${BASE_FOLDER}/base/domain/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "full:"$0}' >>"${BASE_FOLDER}/v/proxy"

cat ${BASE_FOLDER}/base/domain/*.wg 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "full:"$0}' >>"${BASE_FOLDER}/v/wg"

cat ${BASE_FOLDER}/base/domain/*.local 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "full:"$0}' >>"${BASE_FOLDER}/v/local"

cat ${BASE_FOLDER}/base/domain/*.reject 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "full:"$0}' >>"${BASE_FOLDER}/v/reject"

# Domain-keywords lists
cat ${BASE_FOLDER}/base/domain_keywords/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "keyword:"$0}' >>"${BASE_FOLDER}/v/proxy"

cat ${BASE_FOLDER}/base/domain_keywords/*.wg 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "keyword:"$0}' >>"${BASE_FOLDER}/v/wg"

cat ${BASE_FOLDER}/base/domain_keywords/*.gia 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "keyword:"$0}' >>"${BASE_FOLDER}/v/proxy"
