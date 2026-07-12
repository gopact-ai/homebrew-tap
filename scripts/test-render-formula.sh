#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

cat >"$tmp/checksums.txt" <<'EOF'
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa  9a_1.2.3_darwin_amd64.tar.gz
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  9a_1.2.3_darwin_arm64.tar.gz
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc  9a_1.2.3_linux_amd64.tar.gz
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd  9a_1.2.3_linux_arm64.tar.gz
EOF

"$root/scripts/render-formula.sh" 1.2.3 "$tmp/checksums.txt" >"$tmp/ninea.rb"

for expected in \
	'class Ninea < Formula' \
	'version "1.2.3"' \
	'https://github.com/gopact-ai/9a/releases/download/v1.2.3/9a_1.2.3_darwin_amd64.tar.gz' \
	'sha256 "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"' \
	'https://github.com/gopact-ai/9a/releases/download/v1.2.3/9a_1.2.3_linux_arm64.tar.gz' \
	'sha256 "dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd"' \
	'bin.install "9a", "ninead"'
do
	grep -Fq "$expected" "$tmp/ninea.rb" || {
		printf 'generated formula is missing: %s\n' "$expected" >&2
		exit 1
	}
done

if "$root/scripts/render-formula.sh" invalid "$tmp/checksums.txt" >/dev/null 2>&1; then
	printf 'invalid version accepted\n' >&2
	exit 1
fi
