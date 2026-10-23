class Steve < Formula
  desc "Self-hosted delegation, follow-up and records for your coding agents"
  homepage "https://github.com/gopact-ai/steve"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/steve/releases/download/v0.2.1/steve_0.2.1_darwin_arm64.tar.gz"
      sha256 "d23907ced212a5187d5423881e44f367f4abe49c5f82f0a37ceb41635f9b78c4"
    else
      url "https://github.com/gopact-ai/steve/releases/download/v0.2.1/steve_0.2.1_darwin_amd64.tar.gz"
      sha256 "141471725be1aa950df57ef00d69f1ec939370798b662ec5c7b19ec91d2e8741"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/steve/releases/download/v0.2.1/steve_0.2.1_linux_arm64.tar.gz"
      sha256 "993d10f49dd7578a9a4665b18f0a895aa4d3069485bbe503c50852356b404923"
    else
      url "https://github.com/gopact-ai/steve/releases/download/v0.2.1/steve_0.2.1_linux_amd64.tar.gz"
      sha256 "afc6ccb458a27456652cc0ccc6d6095888ad8095ab6fd7fb616e397bf24acc1f"
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
