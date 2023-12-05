#!/bin/bash

SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)
echo $SHELL_FOLDER

rm -f ${SHELL_FOLDER}/surge/*

# UserAgent lists
cat ${SHELL_FOLDER}/base/useragent/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "USER-AGENT,"$0}' >>"${SHELL_FOLDER}/surge/proxy.list"

# ProcessName lists
cat ${SHELL_FOLDER}/base/process/*.local 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "PROCESS-NAME,"$0}' >>"${SHELL_FOLDER}/surge/local.list"

cat ${SHELL_FOLDER}/base/process/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "PROCESS-NAME,"$0}' >>"${SHELL_FOLDER}/surge/proxy.list"

# Domain-suffix lists
cat ${SHELL_FOLDER}/base/domains/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN-SUFFIX,"$0}' >>"${SHELL_FOLDER}/surge/proxy.list"

cat ${SHELL_FOLDER}/base/domains/*.wk 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN-SUFFIX,"$0}' >>"${SHELL_FOLDER}/surge/wk.list"

cat ${SHELL_FOLDER}/base/domains/*.wg 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN-SUFFIX,"$0}' >>"${SHELL_FOLDER}/surge/wg.list"

cat ${SHELL_FOLDER}/base/domains/*.local 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN-SUFFIX,"$0}' >>"${SHELL_FOLDER}/surge/local.list"

cat ${SHELL_FOLDER}/base/domains/*.direct 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN-SUFFIX,"$0}' >>"${SHELL_FOLDER}/surge/direct.list"

cat ${SHELL_FOLDER}/base/domains/*.reject 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN-SUFFIX,"$0}' >>"${SHELL_FOLDER}/surge/reject.list"

# Domain lists

cat ${SHELL_FOLDER}/base/domain/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN,"$0}' >>"${SHELL_FOLDER}/surge/proxy.list"

cat ${SHELL_FOLDER}/base/domain/*.wk 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN,"$0}' >>"${SHELL_FOLDER}/surge/wk.list"

cat ${SHELL_FOLDER}/base/domain/*.wg 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN,"$0}' >>"${SHELL_FOLDER}/surge/wg.list"

cat ${SHELL_FOLDER}/base/domain/*.local 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN,"$0}' >>"${SHELL_FOLDER}/surge/local.list"

cat ${SHELL_FOLDER}/base/domain/*.direct 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN,"$0}' >>"${SHELL_FOLDER}/surge/direct.list"

cat ${SHELL_FOLDER}/base/domain/*.reject 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN,"$0}' >>"${SHELL_FOLDER}/surge/reject.list"

# Domain-keywords lists
cat ${SHELL_FOLDER}/base/domain_keywords/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN-KEYWORD,"$0}' >>"${SHELL_FOLDER}/surge/proxy.list"

cat ${SHELL_FOLDER}/base/domain_keywords/*.wg 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN-KEYWORD,"$0}' >>"${SHELL_FOLDER}/surge/wg.list"

cat ${SHELL_FOLDER}/base/domain_keywords/*.wk 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN-KEYWORD,"$0}' >>"${SHELL_FOLDER}/surge/wk.list"

# CIDR lists
cat ${SHELL_FOLDER}/base/cidr/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "IP-CIDR,"$0",no-resolve"}' >>"${SHELL_FOLDER}/surge/proxy.list"

cat ${SHELL_FOLDER}/base/cidr/*.local 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "IP-CIDR,"$0",no-resolve"}' >>"${SHELL_FOLDER}/surge/local.list"

cat ${SHELL_FOLDER}/base/cidr/*.wg 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "IP-CIDR,"$0",no-resolve"}' >>"${SHELL_FOLDER}/surge/wg.list"

cat ${SHELL_FOLDER}/base/cidr/*.wk 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "IP-CIDR,"$0",no-resolve"}' >>"${SHELL_FOLDER}/surge/wk.list"
