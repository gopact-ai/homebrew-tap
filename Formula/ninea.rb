class Ninea < Formula
  desc "Expose MCP, A2A, and HTTP capabilities as filesystem-native skills"
  homepage "https://github.com/gopact-ai/9a"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/9a/releases/download/v0.1.0/9a_0.1.0_darwin_arm64.tar.gz"
      sha256 "91b3b060a414f027046a48c272a5f220b8c6a77e56910f3eae39af4324f0408e"
    else
      url "https://github.com/gopact-ai/9a/releases/download/v0.1.0/9a_0.1.0_darwin_amd64.tar.gz"
      sha256 "ece1fc4e7cd8608be01e7f8569de561bcf6caaa48f9092b86a8fb50d0a711ca8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/9a/releases/download/v0.1.0/9a_0.1.0_linux_arm64.tar.gz"
      sha256 "742f6cf08a03d175d6a12fb1c6bb82b0dc0933198e923b55b5913ffcaa67a084"
    else
      url "https://github.com/gopact-ai/9a/releases/download/v0.1.0/9a_0.1.0_linux_amd64.tar.gz"
      sha256 "8feef59f3273ab3907155abaff23937c4c43f80a07dc93b2a5f087c61f4cae12"
    end
  end

  def install
    bin.install "9a", "ninead"
  end

  test do
    assert_match "usage: 9a <command>", shell_output("#{bin}/9a 2>&1", 1)
    assert_match "-socket string", shell_output("#{bin}/ninead -h 2>&1")
  end
end
