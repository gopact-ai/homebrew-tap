class Ninea < Formula
  desc "Local capability runtime for AI agents"
  homepage "https://github.com/gopact-ai/9a"
  version "0.2.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/9a/releases/download/v0.2.7/9a_0.2.7_darwin_arm64.tar.gz"
      sha256 "317dfa783931fd740e91c3756c11afbd831564a64f28e831d552cf928ab7059e"
    else
      url "https://github.com/gopact-ai/9a/releases/download/v0.2.7/9a_0.2.7_darwin_amd64.tar.gz"
      sha256 "6062464b087684cd34b86fb76404fecdc7679baf8fc53863f936100784eace06"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/9a/releases/download/v0.2.7/9a_0.2.7_linux_arm64.tar.gz"
      sha256 "f9e7f330961d6f96adbd3f8dc2c2fdc6b6f346292125947d153728eb4f571045"
    else
      url "https://github.com/gopact-ai/9a/releases/download/v0.2.7/9a_0.2.7_linux_amd64.tar.gz"
      sha256 "466d53006bf1473513bb3e96e79d20151d4a7f010238f2fddbdc36913e91e253"
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
    assert_match "Usage:", shell_output("#{bin}/9a --help")
    assert_match "9a #{version}", shell_output("#{bin}/9a version")
    assert_match "--socket string", shell_output("#{bin}/9a daemon --help")
  end
end
