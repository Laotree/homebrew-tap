class Llp < Formula
  desc "Read Claude Code session JSONL files and persist them to a local SQLite database"
  homepage "https://github.com/Laotree/logs-locally-plugin"
  url "https://github.com/Laotree/logs-locally-plugin/archive/refs/tags/v0.8.7.tar.gz"
  sha256 "5ff9c1649527b2c8216b54dbbb09d2ced73087447e5be9b78e37880ff4e62ec0"
  version "0.8.7"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/llp --version")
  end
end
