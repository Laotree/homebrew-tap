class Llp < Formula
  desc "Read Claude Code session JSONL files and persist them to a local SQLite database"
  homepage "https://github.com/Laotree/logs-locally-plugin"
  version "0.10.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.10.3/llp-aarch64-apple-darwin.tar.gz"
      sha256 "158d49468e16c2a95af3e935e06cd2fd49c8f3c24ff5c3baf6706211db2b5311"
    end
    on_intel do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.10.3/llp-x86_64-apple-darwin.tar.gz"
      sha256 "1e200fdaa6452800717bfebfc655edcfddb272d95bf98fee1beccd7e906a56cc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.10.3/llp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "682607241e18df7c9733b8d160dbf3132544480f5b0690ae18dfa79bff43d690"
    end
  end

  def install
    bin.install "llp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/llp version")
  end
end
