#!/bin/bash

BASE_FOLDER=$(cd "$(dirname "$0")/..";pwd)
echo $BASE_FOLDER

test -d "${BASE_FOLDER}/surge" || mkdir "${BASE_FOLDER}/surge"
rm -f ${BASE_FOLDER}/surge/*

# UserAgent lists
cat ${BASE_FOLDER}/base/useragent/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "USER-AGENT,"$0}' >>"${BASE_FOLDER}/surge/proxy.list"

# ProcessName lists
cat ${BASE_FOLDER}/base/process/*.local 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "PROCESS-NAME,"$0}' >>"${BASE_FOLDER}/surge/local.list"

cat ${BASE_FOLDER}/base/process/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "PROCESS-NAME,"$0}' >>"${BASE_FOLDER}/surge/proxy.list"

# Domain-suffix lists
cat ${BASE_FOLDER}/base/domains/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN-SUFFIX,"$0}' >>"${BASE_FOLDER}/surge/proxy.list"

cat ${BASE_FOLDER}/base/domains/*.wk 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN-SUFFIX,"$0}' >>"${BASE_FOLDER}/surge/wk.list"

cat ${BASE_FOLDER}/base/domains/*.wg 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN-SUFFIX,"$0}' >>"${BASE_FOLDER}/surge/wg.list"

cat ${BASE_FOLDER}/base/domains/*.local 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN-SUFFIX,"$0}' >>"${BASE_FOLDER}/surge/local.list"

cat ${BASE_FOLDER}/base/domains/*.direct 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN-SUFFIX,"$0}' >>"${BASE_FOLDER}/surge/direct.list"

cat ${BASE_FOLDER}/base/domains/*.reject 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN-SUFFIX,"$0}' >>"${BASE_FOLDER}/surge/reject.list"

# Domain lists

cat ${BASE_FOLDER}/base/domain/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN,"$0}' >>"${BASE_FOLDER}/surge/proxy.list"

cat ${BASE_FOLDER}/base/domain/*.wk 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN,"$0}' >>"${BASE_FOLDER}/surge/wk.list"

cat ${BASE_FOLDER}/base/domain/*.wg 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN,"$0}' >>"${BASE_FOLDER}/surge/wg.list"

cat ${BASE_FOLDER}/base/domain/*.local 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN,"$0}' >>"${BASE_FOLDER}/surge/local.list"

cat ${BASE_FOLDER}/base/domain/*.direct 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN,"$0}' >>"${BASE_FOLDER}/surge/direct.list"

cat ${BASE_FOLDER}/base/domain/*.reject 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN,"$0}' >>"${BASE_FOLDER}/surge/reject.list"

# Domain-keywords lists
cat ${BASE_FOLDER}/base/domain_keywords/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN-KEYWORD,"$0}' >>"${BASE_FOLDER}/surge/proxy.list"

cat ${BASE_FOLDER}/base/domain_keywords/*.wg 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN-KEYWORD,"$0}' >>"${BASE_FOLDER}/surge/wg.list"

cat ${BASE_FOLDER}/base/domain_keywords/*.wk 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN-KEYWORD,"$0}' >>"${BASE_FOLDER}/surge/wk.list"

# CIDR lists
cat ${BASE_FOLDER}/base/cidr/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "IP-CIDR,"$0",no-resolve"}' >>"${BASE_FOLDER}/surge/proxy.list"

cat ${BASE_FOLDER}/base/cidr/*.local 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "IP-CIDR,"$0",no-resolve"}' >>"${BASE_FOLDER}/surge/local.list"

cat ${BASE_FOLDER}/base/cidr/*.wg 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "IP-CIDR,"$0",no-resolve"}' >>"${BASE_FOLDER}/surge/wg.list"

cat ${BASE_FOLDER}/base/cidr/*.wk 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "IP-CIDR,"$0",no-resolve"}' >>"${BASE_FOLDER}/surge/wk.list"
