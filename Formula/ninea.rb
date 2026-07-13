class Ninea < Formula
  desc "Expose MCP, A2A, and HTTP capabilities as filesystem-native skills"
  homepage "https://github.com/gopact-ai/9a"
  version "0.2.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/9a/releases/download/v0.2.5/9a_0.2.5_darwin_arm64.tar.gz"
      sha256 "648acffeea2bef35801aeb9a42003af16bbf78ee5ca7880226c34a6d0440b046"
    else
      url "https://github.com/gopact-ai/9a/releases/download/v0.2.5/9a_0.2.5_darwin_amd64.tar.gz"
      sha256 "cca6d11607a41e2ecc6d0294b356ffd1f8ec46a254536d9c3ae625db0e4cf5c3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/9a/releases/download/v0.2.5/9a_0.2.5_linux_arm64.tar.gz"
      sha256 "20eacf54193d33ca73e6291a7cc57ff4b8996e5c0905e83e36c9658b8544a8b2"
    else
      url "https://github.com/gopact-ai/9a/releases/download/v0.2.5/9a_0.2.5_linux_amd64.tar.gz"
      sha256 "8fa7a82ff69375d23bf750de7be7066d91d774103ce56b58fb35f9349bb00add"
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
