#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck source=lib.sh
source "${SCRIPT_DIR}/lib.sh"

OUTPUT_DIR="${BASE_FOLDER}/shadowrocket"
prepare_output_dir "$OUTPUT_DIR"

temporary=$(mktemp "${OUTPUT_DIR}/config.conf.tmp.XXXXXX")
trap 'rm -f "$temporary"' EXIT

cat > "$temporary" <<'EOF'
[General]
bypass-system = true
skip-proxy = 192.168.0.0/16, 10.0.0.0/8, 172.16.0.0/12, localhost, *.local, captive.apple.com
bypass-tun = 10.0.0.0/8,100.64.0.0/10,127.0.0.0/8,169.254.0.0/16,172.16.0.0/12,192.0.0.0/24,192.0.2.0/24,192.88.99.0/24,192.168.0.0/16,198.18.0.0/15,198.51.100.0/24,203.0.113.0/24,224.0.0.0/4,255.255.255.255/32
dns-server = system
ipv6 = false

[Rule]
EOF

{
    collect_rules "${BASE_FOLDER}/base/domains" proxy | awk '{print "DOMAIN-SUFFIX," $0 ",GROUP1,force-remote-dns"}'
    collect_rules "${BASE_FOLDER}/base/domains" reject | awk '{print "DOMAIN-SUFFIX," $0 ",REJECT"}'
    collect_rules "${BASE_FOLDER}/base/domain_keywords" proxy | awk '{print "DOMAIN-KEYWORD," $0 ",GROUP1,force-remote-dns"}'
    collect_rules "${BASE_FOLDER}/base/cidr" proxy | awk '{print "IP-CIDR," $0 ",GROUP1"}'
} >> "$temporary"

cat >> "$temporary" <<'EOF'
FINAL,direct

[Host]
localhost = 127.0.0.1
EOF

mv "$temporary" "${OUTPUT_DIR}/config.conf"
trap - EXIT
