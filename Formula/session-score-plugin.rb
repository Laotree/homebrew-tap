class SessionScorePlugin < Formula
  desc "Score, analyse, and improve your Claude Code sessions"
  homepage "https://github.com/Laotree/session-score-plugin"
  license "MIT"
  version "0.1.0"
  head "https://github.com/Laotree/session-score-plugin.git", branch: "main"

  on_macos do
    on_arm do
      url "https://github.com/Laotree/session-score-plugin/releases/download/v0.1.0/session-score-plugin-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "6caa33fbf295f458a54bd24b7e582ca9aa074b2e906dff5475798d6430239d52"
    end

    on_intel do
      url "https://github.com/Laotree/session-score-plugin/archive/refs/tags/v0.1.0.tar.gz"
      sha256 "1f0e90da4cfb13329d144c04a67af6fbecf0896609281d8ef6ec7a9afa665ebd"
      depends_on "rust" => :build
    end
  end

  def install
    if Hardware::CPU.arm?
      bin.install "session-score-plugin"
    else
      system "cargo", "install", *std_cargo_args
    end
  end

  test do
    assert_match "session-score-plugin", shell_output("#{bin}/session-score-plugin --help 2>&1")
  end
end
