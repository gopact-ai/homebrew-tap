class Ninea < Formula
  desc "Expose MCP, A2A, and HTTP capabilities as filesystem-native skills"
  homepage "https://github.com/gopact-ai/9a"
  version "0.2.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/9a/releases/download/v0.2.4/9a_0.2.4_darwin_arm64.tar.gz"
      sha256 "7f646c8bae6dddeba04c5da4ba47320861e6f8d54f2bce0268f36803ff8a1b63"
    else
      url "https://github.com/gopact-ai/9a/releases/download/v0.2.4/9a_0.2.4_darwin_amd64.tar.gz"
      sha256 "f72876839c4989268054f36a315b084009c3cc76098de5abba6f38120bf57444"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/9a/releases/download/v0.2.4/9a_0.2.4_linux_arm64.tar.gz"
      sha256 "c1e27bc3de52e021f591013bbc654ce12f3ef2f0b246063232e2dff745749d42"
    else
      url "https://github.com/gopact-ai/9a/releases/download/v0.2.4/9a_0.2.4_linux_amd64.tar.gz"
      sha256 "93c0970b6bbc9e26cbcb5e01451c5ed5cfee48dab734869149d434abdee5542f"
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
