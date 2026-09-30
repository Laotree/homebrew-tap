class VerifyNetworking < Formula
  desc "Network connectivity checker that runs before Claude Code/Codex sessions"
  homepage "https://github.com/Laotree/verify-networking-plugin"
  url "https://github.com/Laotree/verify-networking-plugin/releases/download/v0.3.0/verify-networking-0.3.0-macos.tar.gz"
  sha256 "2f685cfe51dc3a6ccc2df97da9077dc7779c008339a2de55b880d11151cd744d"
  version "0.3.0"

  def install
    bin.install "verify-networking"
  end

  test do
    assert_predicate bin/"verify-networking", :exist?
  end
end
