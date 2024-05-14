#!/bin/bash

SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)
echo $SHELL_FOLDER

rm -f ${SHELL_FOLDER}/autoproxy/*

echo "[AutoProxy]" >"${SHELL_FOLDER}/autoproxy/proxy.list.tmp"
echo "[AutoProxy]" >"${SHELL_FOLDER}/autoproxy/gia.list.tmp"
echo "[AutoProxy]" >"${SHELL_FOLDER}/autoproxy/local.list.tmp"
echo "[AutoProxy]" >"${SHELL_FOLDER}/autoproxy/reject.list.tmp"
echo "[AutoProxy]" >"${SHELL_FOLDER}/autoproxy/wg.list.tmp"
echo "[AutoProxy]" >"${SHELL_FOLDER}/autoproxy/wk.list.tmp"


# Domain-suffix lists
cat ${SHELL_FOLDER}/base/domains/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "||"$0}' >>"${SHELL_FOLDER}/autoproxy/proxy.list.tmp"

cat ${SHELL_FOLDER}/base/domains/*.wk 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "||"$0}' >>"${SHELL_FOLDER}/autoproxy/wk.list.tmp"

cat ${SHELL_FOLDER}/base/domains/*.wg 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "||"$0}' >>"${SHELL_FOLDER}/autoproxy/wg.list.tmp"

cat ${SHELL_FOLDER}/base/domains/*.local 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "||"$0}' >>"${SHELL_FOLDER}/autoproxy/local.list.tmp"

cat ${SHELL_FOLDER}/base/domains/*.reject 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "||"$0}' >>"${SHELL_FOLDER}/autoproxy/reject.list.tmp"

cat ${SHELL_FOLDER}/base/domains/*.gia 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "||"$0}' >>"${SHELL_FOLDER}/autoproxy/gia.list.tmp"

# Domain lists

cat ${SHELL_FOLDER}/base/domain/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print $0}' >>"${SHELL_FOLDER}/autoproxy/proxy.list.tmp"

cat ${SHELL_FOLDER}/base/domain/*.wk 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print $0}' >>"${SHELL_FOLDER}/autoproxy/wk.list.tmp"

cat ${SHELL_FOLDER}/base/domain/*.wg 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print $0}' >>"${SHELL_FOLDER}/autoproxy/wg.list.tmp"

cat ${SHELL_FOLDER}/base/domain/*.local 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print $0}' >>"${SHELL_FOLDER}/autoproxy/local.list.tmp"

cat ${SHELL_FOLDER}/base/domain/*.reject 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print $0}' >>"${SHELL_FOLDER}/autoproxy/reject.list.tmp"

# Domain-keywords lists
cat ${SHELL_FOLDER}/base/domain_keywords/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "||*"$0"*"}' >>"${SHELL_FOLDER}/autoproxy/proxy.list.tmp"

cat ${SHELL_FOLDER}/base/domain_keywords/*.wg 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "||*"$0"*"}' >>"${SHELL_FOLDER}/autoproxy/wg.list.tmp"

cat ${SHELL_FOLDER}/base/domain_keywords/*.wk 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "||*"$0"*"}' >>"${SHELL_FOLDER}/autoproxy/wk.list.tmp"

cat ${SHELL_FOLDER}/base/domain_keywords/*.gia 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "||*"$0"*"}' >>"${SHELL_FOLDER}/autoproxy/gia.list.tmp"


cat "${SHELL_FOLDER}/autoproxy/proxy.list.tmp" \
    | base64 | fold -w 64 \
    >"${SHELL_FOLDER}/autoproxy/proxy.list"
cat "${SHELL_FOLDER}/autoproxy/gia.list.tmp" \
    | base64 | fold -w 64 \
    >>"${SHELL_FOLDER}/autoproxy/proxy.list"
cat "${SHELL_FOLDER}/autoproxy/local.list.tmp" \
    | base64 | fold -w 64 \
    >"${SHELL_FOLDER}/autoproxy/local.list"
cat "${SHELL_FOLDER}/autoproxy/reject.list.tmp" \
    | base64 | fold -w 64 \
    >"${SHELL_FOLDER}/autoproxy/reject.list"
cat "${SHELL_FOLDER}/autoproxy/wg.list.tmp" \
    | base64 | fold -w 64 \
    >"${SHELL_FOLDER}/autoproxy/wg.list"
cat "${SHELL_FOLDER}/autoproxy/wk.list.tmp" \
    | base64 | fold -w 64 \
    >"${SHELL_FOLDER}/autoproxy/wk.list"

rm -rf ${SHELL_FOLDER}/autoproxy/*.tmp