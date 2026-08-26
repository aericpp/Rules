#!/bin/bash

BASE_FOLDER=$(cd "$(dirname "$0")/..";pwd)
echo $BASE_FOLDER

test -d "${BASE_FOLDER}/raw" || mkdir "${BASE_FOLDER}/raw"
rm -f ${BASE_FOLDER}/raw/*

echo "# raw list" >"${BASE_FOLDER}/raw/proxy.list.tmp"
echo "# raw list" >"${BASE_FOLDER}/raw/local.list.tmp"
echo "# raw list" >"${BASE_FOLDER}/raw/reject.list.tmp"
echo "# raw list" >"${BASE_FOLDER}/raw/wg.list.tmp"
echo "# raw list" >"${BASE_FOLDER}/raw/wk.list.tmp"


# Domain-suffix lists
cat ${BASE_FOLDER}/base/domains/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "||"$0}' >>"${BASE_FOLDER}/raw/proxy.list.tmp"

cat ${BASE_FOLDER}/base/domains/*.wk 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "||"$0}' >>"${BASE_FOLDER}/raw/wk.list.tmp"

cat ${BASE_FOLDER}/base/domains/*.wg 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "||"$0}' >>"${BASE_FOLDER}/raw/wg.list.tmp"

cat ${BASE_FOLDER}/base/domains/*.local 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "||"$0}' >>"${BASE_FOLDER}/raw/local.list.tmp"

cat ${BASE_FOLDER}/base/domains/*.reject 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "||"$0}' >>"${BASE_FOLDER}/raw/reject.list.tmp"

# Domain lists

cat ${BASE_FOLDER}/base/domain/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print $0}' >>"${BASE_FOLDER}/raw/proxy.list.tmp"

cat ${BASE_FOLDER}/base/domain/*.wk 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print $0}' >>"${BASE_FOLDER}/raw/wk.list.tmp"

cat ${BASE_FOLDER}/base/domain/*.wg 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print $0}' >>"${BASE_FOLDER}/raw/wg.list.tmp"

cat ${BASE_FOLDER}/base/domain/*.local 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print $0}' >>"${BASE_FOLDER}/raw/local.list.tmp"

cat ${BASE_FOLDER}/base/domain/*.reject 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print $0}' >>"${BASE_FOLDER}/raw/reject.list.tmp"

# Domain-keywords lists
cat ${BASE_FOLDER}/base/domain_keywords/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "||*"$0"*"}' >>"${BASE_FOLDER}/raw/proxy.list.tmp"

cat ${BASE_FOLDER}/base/domain_keywords/*.wg 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "||*"$0"*"}' >>"${BASE_FOLDER}/raw/wg.list.tmp"

cat ${BASE_FOLDER}/base/domain_keywords/*.wk 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "||*"$0"*"}' >>"${BASE_FOLDER}/raw/wk.list.tmp"

mv "${BASE_FOLDER}/raw/proxy.list.tmp" "${BASE_FOLDER}/raw/proxy_raw.list"
mv "${BASE_FOLDER}/raw/local.list.tmp" "${BASE_FOLDER}/raw/local_raw.list"
mv "${BASE_FOLDER}/raw/reject.list.tmp" "${BASE_FOLDER}/raw/reject_raw.list"
mv "${BASE_FOLDER}/raw/wg.list.tmp" "${BASE_FOLDER}/raw/wg_raw.list"
mv "${BASE_FOLDER}/raw/wk.list.tmp" "${BASE_FOLDER}/raw/wk_raw.list"
