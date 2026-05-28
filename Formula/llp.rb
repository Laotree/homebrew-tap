class Llp < Formula
  desc "Read Claude Code session JSONL files and persist them to a local SQLite database"
  homepage "https://github.com/Laotree/logs-locally-plugin"
  url "https://github.com/Laotree/logs-locally-plugin/archive/refs/tags/v0.8.3.tar.gz"
  sha256 "8a022abc0636deba0882a99e6e640ff23639c4bda9734481c43cae1812b5259b"
  version "0.8.3"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/llp --version")
  end
end
