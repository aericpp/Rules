#!/bin/bash

BASE_FOLDER=$(cd "$(dirname "$0")/..";pwd)
echo $BASE_FOLDER

test -d "${BASE_FOLDER}/shadowrocket" || mkdir "${BASE_FOLDER}/shadowrocket"
rm -f ${BASE_FOLDER}/shadowrocket/*

echo "[General]" >>"${BASE_FOLDER}/shadowrocket/config.conf"
echo "bypass-system = true" >>"${BASE_FOLDER}/shadowrocket/config.conf"
echo "skip-proxy = 192.168.0.0/16, 10.0.0.0/8, 172.16.0.0/12, localhost, *.local, captive.apple.com" >>"${BASE_FOLDER}/shadowrocket/config.conf"
echo "bypass-tun = 10.0.0.0/8,100.64.0.0/10,127.0.0.0/8,169.254.0.0/16,172.16.0.0/12,192.0.0.0/24,192.0.2.0/24,192.88.99.0/24,192.168.0.0/16,198.18.0.0/15,198.51.100.0/24,203.0.113.0/24,224.0.0.0/4,255.255.255.255/32" >>"${BASE_FOLDER}/shadowrocket/config.conf"
echo "dns-server = system" >>"${BASE_FOLDER}/shadowrocket/config.conf"
echo "ipv6 = false" >>"${BASE_FOLDER}/shadowrocket/config.conf"
echo "" >>"${BASE_FOLDER}/shadowrocket/config.conf"

echo '[Rule]' >>"${BASE_FOLDER}/shadowrocket/config.conf"

# UserAgent lists
cat ${BASE_FOLDER}/base/useragent/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "USER-AGENT,"$0",GROUP1"}' >>"${BASE_FOLDER}/shadowrocket/config.conf"

# Domain lists
cat ${BASE_FOLDER}/base/domains/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN-SUFFIX,"$0",GROUP1,force-remote-dns"}' >>"${BASE_FOLDER}/shadowrocket/config.conf"

cat ${BASE_FOLDER}/base/domains/*.reject 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN-SUFFIX,"$0",REJECT"}' >>"${BASE_FOLDER}/shadowrocket/config.conf"

# Domain lists
cat ${BASE_FOLDER}/base/domain_keywords/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "DOMAIN-KEYWORD,"$0",GROUP1,force-remote-dns"}' >>"${BASE_FOLDER}/shadowrocket/config.conf"

# CIDR lists
cat ${BASE_FOLDER}/base/cidr/*.proxy 2>/dev/null \
    | grep -v '^\s*$' \
    | sort  \
    | uniq  \
    | awk '{print "IP-CIDR,"$0",GROUP1"}' >>"${BASE_FOLDER}/shadowrocket/config.conf"

echo "FINAL,direct" >>"${BASE_FOLDER}/shadowrocket/config.conf"
echo "" >>"${BASE_FOLDER}/shadowrocket/config.conf"
echo "[Host]" >>"${BASE_FOLDER}/shadowrocket/config.conf"
echo "localhost = 127.0.0.1" >>"${BASE_FOLDER}/shadowrocket/config.conf"
