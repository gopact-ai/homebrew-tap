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
	filename="9a_${version}_$1_$2.tar.gz"
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
class Ninea < Formula
  desc "Expose MCP, A2A, and HTTP capabilities as filesystem-native skills"
  homepage "https://github.com/gopact-ai/9a"
  version "$version"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/9a/releases/download/v$version/9a_${version}_darwin_arm64.tar.gz"
      sha256 "$darwin_arm64"
    else
      url "https://github.com/gopact-ai/9a/releases/download/v$version/9a_${version}_darwin_amd64.tar.gz"
      sha256 "$darwin_amd64"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/9a/releases/download/v$version/9a_${version}_linux_arm64.tar.gz"
      sha256 "$linux_arm64"
    else
      url "https://github.com/gopact-ai/9a/releases/download/v$version/9a_${version}_linux_amd64.tar.gz"
      sha256 "$linux_amd64"
    end
  end

  def install
    bin.install "9a"
  end

  service do
    run [opt_bin/"9a", "daemon"]
    keep_alive true
  end

  test do
    assert_match "Workspace Commands:", shell_output("#{bin}/9a --help")
    assert_match "9a #{version}", shell_output("#{bin}/9a version")
    assert_match "--socket string", shell_output("#{bin}/9a daemon --help")
  end
end
EOF
