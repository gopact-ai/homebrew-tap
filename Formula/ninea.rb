class Ninea < Formula
  desc "Expose MCP, A2A, and HTTP capabilities as filesystem-native skills"
  homepage "https://github.com/gopact-ai/9a"
  version "0.2.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/9a/releases/download/v0.2.2/9a_0.2.2_darwin_arm64.tar.gz"
      sha256 "0815d57113f4da9c47e6e151144215f8888f0b181a27d8d6e09e6dbc607c2b76"
    else
      url "https://github.com/gopact-ai/9a/releases/download/v0.2.2/9a_0.2.2_darwin_amd64.tar.gz"
      sha256 "74303e344daae49655a2180690f3037a25bddf56ebcea34a09426bb0c446cf10"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/9a/releases/download/v0.2.2/9a_0.2.2_linux_arm64.tar.gz"
      sha256 "579af25e567ec4c22521f287be84aa9629c01322b7a4d1cbe5aee7f4fe18b57f"
    else
      url "https://github.com/gopact-ai/9a/releases/download/v0.2.2/9a_0.2.2_linux_amd64.tar.gz"
      sha256 "864b8e5cc9b69aa5f7a2388ef30d05a60ecd7effc1908eb0abf20e4ca4b50c24"
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
