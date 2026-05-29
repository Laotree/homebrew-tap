class Llp < Formula
  desc "Read Claude Code session JSONL files and persist them to a local SQLite database"
  homepage "https://github.com/Laotree/logs-locally-plugin"
  version "0.8.9"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.8.9/llp-aarch64-apple-darwin.tar.gz"
      sha256 "8f5a19e10a4bbb88bfede7158b03939284dff1e0975b7cb58c81ded99661ab2f"
    end
    on_intel do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.8.9/llp-x86_64-apple-darwin.tar.gz"
      sha256 "90b0006adf7584b44531a3f3d075ccc30990c09ca2017569407910d5f56b2b72"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.8.9/llp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "06600d04b9b21cf49cb06c59ef36ec140f0a5775d5713a17c00efa2498a52bb2"
    end
  end

  def install
    bin.install "llp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/llp version")
  end
end
