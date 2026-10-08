class Llp < Formula
  desc "Read Claude Code session JSONL files and persist them to a local SQLite database"
  homepage "https://github.com/Laotree/logs-locally-plugin"
  version "0.12.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.12.0/llp-aarch64-apple-darwin.tar.gz"
      sha256 "2832d54a93287a829ed968c6b826272110cc9205a4b4f1a3f85d2c844d92fe70"
    end
    on_intel do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.12.0/llp-x86_64-apple-darwin.tar.gz"
      sha256 "3e415d0f407c17816917ea634d5f0170b7d2ded7398d2d78bca0c4a3d565d670"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.12.0/llp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "03b8626b3c8251348ce7be04de1f7ecd5e778be01993ddf9cc7bf53f84124a26"
    end
  end

  def install
    bin.install "llp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/llp version")
  end
end
