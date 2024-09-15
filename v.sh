#!/bin/bash

SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)
echo $SHELL_FOLDER

rm -f ${SHELL_FOLDER}/v/*

echo "# proxy file" >"${SHELL_FOLDER}/v/proxy"
echo "# direct file" >"${SHELL_FOLDER}/v/local"
echo "# reject file" >"${SHELL_FOLDER}/v/reject"
echo "# direct file" >"${SHELL_FOLDER}/v/wg"


# Domain-suffix lists
cat ${SHELL_FOLDER}/base/domains/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "domain:"$0}' >>"${SHELL_FOLDER}/v/proxy"


cat ${SHELL_FOLDER}/base/domains/*.wg 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "domain:"$0}' >>"${SHELL_FOLDER}/v/wg"

cat ${SHELL_FOLDER}/base/domains/*.local 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "domain:"$0}' >>"${SHELL_FOLDER}/v/local"

cat ${SHELL_FOLDER}/base/domains/*.reject 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "domain:"$0}' >>"${SHELL_FOLDER}/v/reject"

cat ${SHELL_FOLDER}/base/domains/*.gia 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "domain:"$0}' >>"${SHELL_FOLDER}/v/proxy"

# Domain lists

cat ${SHELL_FOLDER}/base/domain/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "full:"$0}' >>"${SHELL_FOLDER}/v/proxy"

cat ${SHELL_FOLDER}/base/domain/*.wg 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "full:"$0}' >>"${SHELL_FOLDER}/v/wg"

cat ${SHELL_FOLDER}/base/domain/*.local 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "full:"$0}' >>"${SHELL_FOLDER}/v/local"

cat ${SHELL_FOLDER}/base/domain/*.reject 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "full:"$0}' >>"${SHELL_FOLDER}/v/reject"

# Domain-keywords lists
cat ${SHELL_FOLDER}/base/domain_keywords/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "keyword:"$0}' >>"${SHELL_FOLDER}/v/proxy"

cat ${SHELL_FOLDER}/base/domain_keywords/*.wg 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "keyword:"$0}' >>"${SHELL_FOLDER}/v/wg"

cat ${SHELL_FOLDER}/base/domain_keywords/*.gia 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "keyword:"$0}' >>"${SHELL_FOLDER}/v/proxy"
