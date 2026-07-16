class Ninea < Formula
  desc "Local capability runtime for AI agents"
  homepage "https://github.com/gopact-ai/9a"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/9a/releases/download/v0.3.0/9a_0.3.0_darwin_arm64.tar.gz"
      sha256 "c2ee174b0bd55737f5de3f663966c50500d7bacdda4a57facc3d4ee932bf3bbb"
    else
      url "https://github.com/gopact-ai/9a/releases/download/v0.3.0/9a_0.3.0_darwin_amd64.tar.gz"
      sha256 "c9c6278bfa836011cadaa0c0282e00088451a91bca268afd02779b91e5d17204"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/9a/releases/download/v0.3.0/9a_0.3.0_linux_arm64.tar.gz"
      sha256 "5fd283493bc7b0e0cead5ff3af31bf53ad50e61cacf8f89a6e14368fb903086d"
    else
      url "https://github.com/gopact-ai/9a/releases/download/v0.3.0/9a_0.3.0_linux_amd64.tar.gz"
      sha256 "e73a25a90a951f42880ed420cb3c9d30671b816cc7a85a9d820c5157a30e17be"
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
