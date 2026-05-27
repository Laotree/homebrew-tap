class Llp < Formula
  desc "Read Claude Code session JSONL files and persist them to a local SQLite database"
  homepage "https://github.com/Laotree/logs-locally-plugin"
  url "https://github.com/Laotree/logs-locally-plugin/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "021efaf0adc295869531913ea2d5f0d459d67ae6be32006cd61e91ab4ae0bdbd"
  version "0.3.0"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/llp --version")
  end
end
