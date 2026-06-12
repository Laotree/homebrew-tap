class Llp < Formula
  desc "Read Claude Code session JSONL files and persist them to a local SQLite database"
  homepage "https://github.com/Laotree/logs-locally-plugin"
  version "0.10.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.10.1/llp-aarch64-apple-darwin.tar.gz"
      sha256 "41af97029c98937cd951f82e31958acbc7660308b73bfbc9309451c328cc6a94"
    end
    on_intel do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.10.1/llp-x86_64-apple-darwin.tar.gz"
      sha256 "f97f05acd4e3cda9ac36b821bafe7df5b79ea1b6c8e9d086aaee53f3c02f3112"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.10.1/llp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "18ce2da2f0af3502dbb0c02aeca7a19b306f88685efc3a235fff0f841de61799"
    end
  end

  def install
    bin.install "llp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/llp version")
  end
end
