class Llp < Formula
  desc "Read Claude Code session JSONL files and persist them to a local SQLite database"
  homepage "https://github.com/Laotree/logs-locally-plugin"
  version "0.10.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.10.0/llp-aarch64-apple-darwin.tar.gz"
      sha256 "89075e4dee3c9b523d4c65d89f09f0c6cc667df977d54f37225f15050b3e2f62"
    end
    on_intel do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.10.0/llp-x86_64-apple-darwin.tar.gz"
      sha256 "55737a1b57d5c255ade765bc679c3df8ad939815e6747d0f72ece81af4fc7e23"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Laotree/logs-locally-plugin/releases/download/v0.10.0/llp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c0107a5336c056acf3eb9f1b2999ba038caa1f359128d64289d5af84daa03e27"
    end
  end

  def install
    bin.install "llp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/llp version")
  end
end
