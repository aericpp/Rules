# Rules

Proxy rules are maintained as small source lists under `base/` and compiled into
Surge, Shadowrocket, AutoProxy, raw, and V2Ray-compatible outputs.

## Source layout

- `base/domains`: domain suffix rules, such as `example.com`
- `base/domain`: exact domain rules
- `base/domain_keywords`: keyword rules
- `base/cidr`: IPv4 CIDR rules
- `base/process`: process-name rules for Surge

The file extension selects the target group, for example `proxy`, `ai`,
`direct`, `local`, `reject`, `wg`, or `wk`. Generators discover groups from
the source filenames and merge rules with the same extension, preserving
each rule type supported by the output format. Rules are normalized and
deduplicated within each type and group.

Shadowrocket exports a separate list for each group. Its standalone
`config.conf` routes `ai` rules through the existing `GROUP1` policy.

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

Run `bash scripts/sort.sh` to sort and deduplicate text files under `base/`.
Use `bash scripts/sort.sh --check` to check ordering without modifying files.

To build the complete release, including `dlc.dat` and `geoip.dat`, run:

```bash
bash entrypoint.sh
```

The complete release is written to `release/`. Generated directories and
upstream checkouts are ignored by Git.

## Release contents

The release contains the raw client directories, compressed archives for each
client, flattened list files, and the generated `dlc.dat` and `geoip.dat` files.
