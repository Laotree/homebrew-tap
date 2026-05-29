class Llp < Formula
  desc "Read Claude Code session JSONL files and persist them to a local SQLite database"
  homepage "https://github.com/Laotree/logs-locally-plugin"
  version "0.9.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.9.0/llp-aarch64-apple-darwin.tar.gz"
      sha256 "1be8e92500b34c13f3fbee8fcc5ad908cc4bea53b16247baabb6d271f1385345"
    end
    on_intel do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.9.0/llp-x86_64-apple-darwin.tar.gz"
      sha256 "1ee938867f20948732b790a74687df2af3f489afeae17f40932f6a5361b07c02"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.9.0/llp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c449799ba15ba1bc11cd9f47f166201a1d132a3db008518ae509c692167677a4"
    end
  end

  def install
    bin.install "llp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/llp version")
  end
end
