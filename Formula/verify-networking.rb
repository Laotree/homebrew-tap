class VerifyNetworking < Formula
  desc "Network connectivity checker that runs before Claude Code/Codex sessions"
  homepage "https://github.com/Laotree/verify-networking-plugin"
  url "https://github.com/Laotree/verify-networking-plugin/releases/download/v0.1.0/verify-networking-0.1.0-macos.tar.gz"
  sha256 "2ba0d0f1d10436845724a84f8615a76716473e1c61c57f40d28372eec09c9314"
  version "0.1.0"

  def install
    bin.install "verify-networking"
  end

  test do
    assert_predicate bin/"verify-networking", :exist?
  end
end
