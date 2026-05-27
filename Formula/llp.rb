class Llp < Formula
  desc "Read Claude Code session JSONL files and persist them to a local SQLite database"
  homepage "https://github.com/Laotree/logs-locally-plugin"
  url "https://github.com/Laotree/logs-locally-plugin/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "c108978d110b1d1437af560ba86be564ca610a33efa925c684e06e8835fb9f72"
  version "0.5.0"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/llp --version")
  end
end
