class Llp < Formula
  desc "Read Claude Code session JSONL files and persist them to a local SQLite database"
  homepage "https://github.com/Laotree/logs-locally-plugin"
  url "https://github.com/Laotree/logs-locally-plugin.git",
      revision: "b878f9ce2abf6717eed55176e5dc5475a8958bb2"
  version "0.2.0"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/llp --version")
  end
end
