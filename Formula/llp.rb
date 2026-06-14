class Llp < Formula
  desc "Read Claude Code session JSONL files and persist them to a local SQLite database"
  homepage "https://github.com/Laotree/logs-locally-plugin"
  version "0.11.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.11.0/llp-aarch64-apple-darwin.tar.gz"
      sha256 "20dd13bdc24f4ca03374c87040edfc94d8ac2de748e30320002e6c43b047b5f9"
    end
    on_intel do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.11.0/llp-x86_64-apple-darwin.tar.gz"
      sha256 "69f8c0c5a75d7f88343fe8d0df439a77775e83a20db7974e450629d49010260f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.11.0/llp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e5c49bf3d6e935ee914b1a964ed41fc221b3242f2bb9a855c99d932c83e93d28"
    end
  end

  def install
    bin.install "llp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/llp version")
  end
end
