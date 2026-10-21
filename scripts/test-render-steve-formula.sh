#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

cat >"$tmp/checksums.txt" <<'EOF'
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa  steve_1.2.3_darwin_amd64.tar.gz
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  steve_1.2.3_darwin_arm64.tar.gz
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc  steve_1.2.3_linux_amd64.tar.gz
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd  steve_1.2.3_linux_arm64.tar.gz
EOF

"$root/scripts/render-steve-formula.sh" 1.2.3 "$tmp/checksums.txt" >"$tmp/steve.rb"

for expected in \
	'class Steve < Formula' \
	'version "1.2.3"' \
	'https://github.com/gopact-ai/steve/releases/download/v1.2.3/steve_1.2.3_darwin_arm64.tar.gz' \
	'sha256 "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"' \
	'https://github.com/gopact-ai/steve/releases/download/v1.2.3/steve_1.2.3_linux_amd64.tar.gz' \
	'sha256 "cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc"' \
	'bin.install "steve"' \
	'bin.install "steve-node"' \
	'assert_match "steve #{version}", shell_output("#{bin}/steve version")'
do
	grep -Fq "$expected" "$tmp/steve.rb" || {
		printf 'generated formula is missing: %s\n' "$expected" >&2
		exit 1
	}
done

if "$root/scripts/render-steve-formula.sh" invalid "$tmp/checksums.txt" >/dev/null 2>&1; then
	printf 'invalid version accepted\n' >&2
	exit 1
fi
