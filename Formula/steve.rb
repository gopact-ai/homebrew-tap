class Steve < Formula
  desc "Self-hosted delegation, follow-up and records for your coding agents"
  homepage "https://github.com/gopact-ai/steve"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/steve/releases/download/v0.2.0/steve_0.2.0_darwin_arm64.tar.gz"
      sha256 "4771348894d97c2eabc6e1bc1a66bf119fbc530fba38e785405af304b262e227"
    else
      url "https://github.com/gopact-ai/steve/releases/download/v0.2.0/steve_0.2.0_darwin_amd64.tar.gz"
      sha256 "6f71ea3d4f7f979ccefc25445d5d882d0b8ba094b0e35d025abf9c9a105fcdad"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/steve/releases/download/v0.2.0/steve_0.2.0_linux_arm64.tar.gz"
      sha256 "79a0bb59ab3658d54e91fe226b954f309ca1604033c3a416d75b777d93a73d83"
    else
      url "https://github.com/gopact-ai/steve/releases/download/v0.2.0/steve_0.2.0_linux_amd64.tar.gz"
      sha256 "69709e4624a47c37c57f6e0e3d52127806d1eb20fbecb40ff3db9ff0f9988fd2"
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
