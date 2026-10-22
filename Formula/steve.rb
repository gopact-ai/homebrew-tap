class Steve < Formula
  desc "Self-hosted delegation, follow-up and records for your coding agents"
  homepage "https://github.com/gopact-ai/steve"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/steve/releases/download/v0.1.0/steve_0.1.0_darwin_arm64.tar.gz"
      sha256 "17fd28861bb7bc0832e4b798de268e3102021d3478f09839e88f95322c3dddf8"
    else
      url "https://github.com/gopact-ai/steve/releases/download/v0.1.0/steve_0.1.0_darwin_amd64.tar.gz"
      sha256 "beb72a7c8e783425f37500d1d2bdba8b0db66f21ff894fb7132d0e41ac256970"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/steve/releases/download/v0.1.0/steve_0.1.0_linux_arm64.tar.gz"
      sha256 "35c5d8df37ce767dd55226885cdf8ebd0a26208569fe71a3ba1ee4668c7447fd"
    else
      url "https://github.com/gopact-ai/steve/releases/download/v0.1.0/steve_0.1.0_linux_amd64.tar.gz"
      sha256 "830555f5b0a4140cd3cd83792c45009cef92f6a6025739290fc56896c13d460d"
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
