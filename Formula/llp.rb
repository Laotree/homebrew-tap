class Llp < Formula
  desc "Read Claude Code session JSONL files and persist them to a local SQLite database"
  homepage "https://github.com/Laotree/logs-locally-plugin"
  version "0.9.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.9.1/llp-aarch64-apple-darwin.tar.gz"
      sha256 "5492a50be0066764545669afa00d0801240aaaac56d1d428c89d2c5697399c50"
    end
    on_intel do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.9.1/llp-x86_64-apple-darwin.tar.gz"
      sha256 "a1c130409f5b75ccc00078872888c3b018508a733eb9fd81a2d2ca272155e5ab"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.9.1/llp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0dd9ee30b8fe7ad01bc00c4d4212c38113579afebb41abee1f0b1c2b31307c59"
    end
  end

  def install
    bin.install "llp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/llp version")
  end
end
