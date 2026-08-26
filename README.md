# Rules

Proxy rules are maintained as small source lists under `base/` and compiled into
Surge, Shadowrocket, AutoProxy, raw, and V2Ray-compatible outputs.

## Source layout

- `base/domains`: domain suffix rules, such as `example.com`
- `base/domain`: exact domain rules
- `base/domain_keywords`: keyword rules
- `base/cidr`: IPv4 CIDR rules
- `base/process`: process-name rules for Surge

The filename suffix selects the target group: `proxy`, `direct`, `local`,
`reject`, `wg`, or `wk`. Rules are normalized and deduplicated when generated.

## Local usage

Validate and generate client rules without downloading upstream repositories:

```bash
bash scripts/validate.sh
bash scripts/surge.sh
bash scripts/shadowrocket.sh
bash scripts/autoproxy.sh
bash scripts/raw.sh
bash scripts/v.sh
```

Run `bash scripts/sort.sh --fix` only when intentionally formatting source
lists. The default `sort.sh` mode checks ordering without modifying source files.

To build the complete release, including `dlc.dat` and `geoip.dat`, run:

```bash
bash entrypoint.sh
```

The complete release is written to `release/`. Generated directories and
upstream checkouts are ignored by Git.

## Release contents

The release contains the raw client directories, compressed archives for each
client, flattened list files, and the generated `dlc.dat` and `geoip.dat` files.
