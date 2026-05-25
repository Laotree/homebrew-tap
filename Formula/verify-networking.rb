class VerifyNetworking < Formula
  desc "Network connectivity checker that runs before Claude Code/Codex sessions"
  homepage "https://github.com/Laotree/verify-networking-plugin"
  url "https://github.com/Laotree/verify-networking-plugin/releases/download/v0.1.0/verify-networking-0.1.0-macos.tar.gz"
  sha256 "b32be8e9c6e173fadb7b4e20f6fd1ac8997077fbc02e339c220205700b039469"
  version "0.1.0"

  def install
    bin.install "verify-networking"
  end

  test do
    assert_predicate bin/"verify-networking", :exist?
  end
end
