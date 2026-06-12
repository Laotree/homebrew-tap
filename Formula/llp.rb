class Llp < Formula
  desc "Read Claude Code session JSONL files and persist them to a local SQLite database"
  homepage "https://github.com/Laotree/logs-locally-plugin"
  version "0.10.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.10.2/llp-aarch64-apple-darwin.tar.gz"
      sha256 "88b80c27c2009507ad00391d6ee419ccda88d422e81951bfdd918033cadfc029"
    end
    on_intel do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.10.2/llp-x86_64-apple-darwin.tar.gz"
      sha256 "0d004148c01a64cdfb679a6531f898ccde371af433169598e4a5167f48499fe1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.10.2/llp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "72a28485d915af06cc7ae08a69e362acd11c85d3735d7654db88e4fc1301fbe6"
    end
  end

  def install
    bin.install "llp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/llp version")
  end
end
