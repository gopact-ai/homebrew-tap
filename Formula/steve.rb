class Steve < Formula
  desc "Self-hosted delegation, follow-up and records for your coding agents"
  homepage "https://github.com/gopact-ai/steve"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/steve/releases/download/v0.1.1/steve_0.1.1_darwin_arm64.tar.gz"
      sha256 "f40865ff67e597833d95e5170a02ad876053af05062b91a9c9ce17905ea8fa2b"
    else
      url "https://github.com/gopact-ai/steve/releases/download/v0.1.1/steve_0.1.1_darwin_amd64.tar.gz"
      sha256 "5ed9a24f946e4242b5ad297a622bb6511cd1fbdcc14ef8a7d5e4cf0f2298f236"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/steve/releases/download/v0.1.1/steve_0.1.1_linux_arm64.tar.gz"
      sha256 "c6eb1ca8952b229af8b19332f7e50ea5b9b62908bad782f1680874ba685e25ca"
    else
      url "https://github.com/gopact-ai/steve/releases/download/v0.1.1/steve_0.1.1_linux_amd64.tar.gz"
      sha256 "e4b60e27b1ff71c69a9c2f2be7b424a7044d3083c32e8d34325572693f707beb"
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
