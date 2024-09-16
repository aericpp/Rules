#!/bin/bash

BASE_FOLDER=$(cd "$(dirname "$0")/..";pwd)
echo $BASE_FOLDER

test -d "${BASE_FOLDER}/autoproxy" || mkdir "${BASE_FOLDER}/autoproxy"
rm -f ${BASE_FOLDER}/autoproxy/*

echo "[AutoProxy]" >"${BASE_FOLDER}/autoproxy/proxy.list.tmp"
echo "[AutoProxy]" >"${BASE_FOLDER}/autoproxy/local.list.tmp"
echo "[AutoProxy]" >"${BASE_FOLDER}/autoproxy/reject.list.tmp"
echo "[AutoProxy]" >"${BASE_FOLDER}/autoproxy/wg.list.tmp"
echo "[AutoProxy]" >"${BASE_FOLDER}/autoproxy/wk.list.tmp"


# Domain-suffix lists
cat ${BASE_FOLDER}/base/domains/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "||"$0}' >>"${BASE_FOLDER}/autoproxy/proxy.list.tmp"

cat ${BASE_FOLDER}/base/domains/*.wk 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "||"$0}' >>"${BASE_FOLDER}/autoproxy/wk.list.tmp"

cat ${BASE_FOLDER}/base/domains/*.wg 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "||"$0}' >>"${BASE_FOLDER}/autoproxy/wg.list.tmp"

cat ${BASE_FOLDER}/base/domains/*.local 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "||"$0}' >>"${BASE_FOLDER}/autoproxy/local.list.tmp"

cat ${BASE_FOLDER}/base/domains/*.reject 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "||"$0}' >>"${BASE_FOLDER}/autoproxy/reject.list.tmp"

# Domain lists

cat ${BASE_FOLDER}/base/domain/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print $0}' >>"${BASE_FOLDER}/autoproxy/proxy.list.tmp"

cat ${BASE_FOLDER}/base/domain/*.wk 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print $0}' >>"${BASE_FOLDER}/autoproxy/wk.list.tmp"

cat ${BASE_FOLDER}/base/domain/*.wg 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print $0}' >>"${BASE_FOLDER}/autoproxy/wg.list.tmp"

cat ${BASE_FOLDER}/base/domain/*.local 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print $0}' >>"${BASE_FOLDER}/autoproxy/local.list.tmp"

cat ${BASE_FOLDER}/base/domain/*.reject 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print $0}' >>"${BASE_FOLDER}/autoproxy/reject.list.tmp"

# Domain-keywords lists
cat ${BASE_FOLDER}/base/domain_keywords/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "||*"$0"*"}' >>"${BASE_FOLDER}/autoproxy/proxy.list.tmp"

cat ${BASE_FOLDER}/base/domain_keywords/*.wg 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "||*"$0"*"}' >>"${BASE_FOLDER}/autoproxy/wg.list.tmp"

cat ${BASE_FOLDER}/base/domain_keywords/*.wk 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "||*"$0"*"}' >>"${BASE_FOLDER}/autoproxy/wk.list.tmp"

cat "${BASE_FOLDER}/autoproxy/proxy.list.tmp" \
    | base64 | fold -w 64 \
    >"${BASE_FOLDER}/autoproxy/proxy.list"
cat "${BASE_FOLDER}/autoproxy/local.list.tmp" \
    | base64 | fold -w 64 \
    >"${BASE_FOLDER}/autoproxy/local.list"
cat "${BASE_FOLDER}/autoproxy/reject.list.tmp" \
    | base64 | fold -w 64 \
    >"${BASE_FOLDER}/autoproxy/reject.list"
cat "${BASE_FOLDER}/autoproxy/wg.list.tmp" \
    | base64 | fold -w 64 \
    >"${BASE_FOLDER}/autoproxy/wg.list"
cat "${BASE_FOLDER}/autoproxy/wk.list.tmp" \
    | base64 | fold -w 64 \
    >"${BASE_FOLDER}/autoproxy/wk.list"

rm -rf ${BASE_FOLDER}/autoproxy/*.tmp