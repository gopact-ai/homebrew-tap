#!/bin/sh
set -eu

if [ "$#" -ne 2 ]; then
	printf 'usage: %s <version> <checksums-file>\n' "$0" >&2
	exit 2
fi

version=$1
checksums=$2

if ! printf '%s\n' "$version" | grep -Eq '^[0-9]+\.[0-9]+\.[0-9]+$'; then
	printf 'invalid stable version: %s\n' "$version" >&2
	exit 2
fi

checksum() {
	filename="steve_${version}_$1_$2.tar.gz"
	value=$(awk -v filename="$filename" '$2 == filename { print $1 }' "$checksums")
	if ! printf '%s\n' "$value" | grep -Eq '^[0-9a-f]{64}$'; then
		printf 'missing or invalid checksum for %s\n' "$filename" >&2
		exit 1
	fi
	printf '%s' "$value"
}

darwin_amd64=$(checksum darwin amd64)
darwin_arm64=$(checksum darwin arm64)
linux_amd64=$(checksum linux amd64)
linux_arm64=$(checksum linux arm64)

cat <<EOF
class Steve < Formula
  desc "Self-hosted delegation, follow-up and records for your coding agents"
  homepage "https://github.com/gopact-ai/steve"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/steve/releases/download/v$version/steve_${version}_darwin_arm64.tar.gz"
      sha256 "$darwin_arm64"
    else
      url "https://github.com/gopact-ai/steve/releases/download/v$version/steve_${version}_darwin_amd64.tar.gz"
      sha256 "$darwin_amd64"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/steve/releases/download/v$version/steve_${version}_linux_arm64.tar.gz"
      sha256 "$linux_arm64"
    else
      url "https://github.com/gopact-ai/steve/releases/download/v$version/steve_${version}_linux_amd64.tar.gz"
      sha256 "$linux_amd64"
    end
  end

  def install
    bin.install "steve"
    bin.install "steve-node"
  end

  def caveats
    <<~EOS
      Start with:
        steve init
    EOS
  end

  test do
    assert_match "steve #{version}", shell_output("#{bin}/steve version")
  end
end
EOF
