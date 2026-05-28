class Llp < Formula
  desc "Read Claude Code session JSONL files and persist them to a local SQLite database"
  homepage "https://github.com/Laotree/logs-locally-plugin"
  url "https://github.com/Laotree/logs-locally-plugin/archive/refs/tags/v0.8.6.tar.gz"
  sha256 "d0f5cc73b705d3801284402b1a06c3f6ebbe1aebcef8e29dbd03e7fa2e7f6e3c"
  version "0.8.6"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/llp --version")
  end
end
