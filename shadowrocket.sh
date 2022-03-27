#!/bin/bash

SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)
echo $SHELL_FOLDER

rm -f ${SHELL_FOLDER}/shadowrocket/*

echo "[General]" >>"${SHELL_FOLDER}/shadowrocket/config.conf"
echo "bypass-system = true" >>"${SHELL_FOLDER}/shadowrocket/config.conf"
echo "skip-proxy = 192.168.0.0/16, 10.0.0.0/8, 172.16.0.0/12, localhost, *.local, captive.apple.com" >>"${SHELL_FOLDER}/shadowrocket/config.conf"
echo "bypass-tun = 10.0.0.0/8,100.64.0.0/10,127.0.0.0/8,169.254.0.0/16,172.16.0.0/12,192.0.0.0/24,192.0.2.0/24,192.88.99.0/24,192.168.0.0/16,198.18.0.0/15,198.51.100.0/24,203.0.113.0/24,224.0.0.0/4,255.255.255.255/32" >>"${SHELL_FOLDER}/shadowrocket/config.conf"
echo "dns-server = system" >>"${SHELL_FOLDER}/shadowrocket/config.conf"
echo "ipv6 = false" >>"${SHELL_FOLDER}/shadowrocket/config.conf"
echo "" >>"${SHELL_FOLDER}/shadowrocket/config.conf"

echo '[Rule]' >>"${SHELL_FOLDER}/shadowrocket/config.conf"

# UserAgent lists
cat ${SHELL_FOLDER}/base/useragent/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "USER-AGENT,"$0",GROUP1"}' >>"${SHELL_FOLDER}/shadowrocket/config.conf"

# Domain lists
cat ${SHELL_FOLDER}/base/domains/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN-SUFFIX,"$0",GROUP1,force-remote-dns"}' >>"${SHELL_FOLDER}/shadowrocket/config.conf"

cat ${SHELL_FOLDER}/base/domains/*.reject 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN-SUFFIX,"$0",REJECT"}' >>"${SHELL_FOLDER}/shadowrocket/config.conf"

# Domain lists
cat ${SHELL_FOLDER}/base/domain_keywords/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN-KEYWORD,"$0",GROUP1,force-remote-dns"}' >>"${SHELL_FOLDER}/shadowrocket/config.conf"

# CIDR lists
cat ${SHELL_FOLDER}/base/cidr/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "IP-CIDR,"$0",GROUP1"}' >>"${SHELL_FOLDER}/shadowrocket/config.conf"

echo "FINAL,direct" >>"${SHELL_FOLDER}/shadowrocket/config.conf"
echo "" >>"${SHELL_FOLDER}/shadowrocket/config.conf"
echo "[Host]" >>"${SHELL_FOLDER}/shadowrocket/config.conf"
echo "localhost = 127.0.0.1" >>"${SHELL_FOLDER}/shadowrocket/config.conf"
