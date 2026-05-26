class SessionScorePlugin < Formula
  desc "Score, analyse, and improve your Claude Code sessions"
  homepage "https://github.com/Laotree/session-score-plugin"
  url "https://github.com/Laotree/session-score-plugin/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "1f0e90da4cfb13329d144c04a67af6fbecf0896609281d8ef6ec7a9afa665ebd"
  license "MIT"
  head "https://github.com/Laotree/session-score-plugin.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "session-score-plugin", shell_output("#{bin}/session-score-plugin --help 2>&1")
  end
end
