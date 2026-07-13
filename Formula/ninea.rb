class Ninea < Formula
  desc "Expose MCP, A2A, and HTTP capabilities as filesystem-native skills"
  homepage "https://github.com/gopact-ai/9a"
  version "0.2.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/9a/releases/download/v0.2.3/9a_0.2.3_darwin_arm64.tar.gz"
      sha256 "fa3a48c924ed94786df92098330214e014ab697d1fa7c9f54d94c13f01502ba9"
    else
      url "https://github.com/gopact-ai/9a/releases/download/v0.2.3/9a_0.2.3_darwin_amd64.tar.gz"
      sha256 "fff7c053eb2d8be17819c1fddef22dd3a58f697378a71116a2deac3dd6751c70"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/9a/releases/download/v0.2.3/9a_0.2.3_linux_arm64.tar.gz"
      sha256 "79fc6b38638cdead417f8cdc55f304fb24be734f5963e2ccdc9e862a976ebe69"
    else
      url "https://github.com/gopact-ai/9a/releases/download/v0.2.3/9a_0.2.3_linux_amd64.tar.gz"
      sha256 "6e9902dc674140b925b6685bce51a5834cfefa237a4d607c6fa4154c06c43cae"
    end
  end

  def install
    bin.install "9a", "ninead"
  end

  test do
    assert_match "Workspace Commands:", shell_output("#{bin}/9a --help")
    assert_match "9a #{version}", shell_output("#{bin}/9a version")
    assert_match "-socket string", shell_output("#{bin}/ninead -h 2>&1")
  end
end
