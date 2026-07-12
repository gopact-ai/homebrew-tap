class Ninea < Formula
  desc "Expose MCP, A2A, and HTTP capabilities as filesystem-native skills"
  homepage "https://github.com/gopact-ai/9a"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/9a/releases/download/v0.2.0/9a_0.2.0_darwin_arm64.tar.gz"
      sha256 "fd78a7cae5097775ce4f4f76d000ec395336a175d3ddf45487ede6ce7a2bff7d"
    else
      url "https://github.com/gopact-ai/9a/releases/download/v0.2.0/9a_0.2.0_darwin_amd64.tar.gz"
      sha256 "f4ff045c77e2f9712ec4e3aefe8f431625188482aef52b4d0215f56dd145f45c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/gopact-ai/9a/releases/download/v0.2.0/9a_0.2.0_linux_arm64.tar.gz"
      sha256 "00ae9c1ed3f10f7b0b780a7f574175ddb6b32d414bf5599f2077c9d5d9d50b98"
    else
      url "https://github.com/gopact-ai/9a/releases/download/v0.2.0/9a_0.2.0_linux_amd64.tar.gz"
      sha256 "14d11791f179157d138cd151cfc09a3e8b7c8c810b76018f17eada42df32265f"
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
