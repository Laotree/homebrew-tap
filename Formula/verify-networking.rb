class VerifyNetworking < Formula
  desc "Network connectivity checker that runs before Claude Code/Codex sessions"
  homepage "https://github.com/Laotree/verify-networking-plugin"
  url "https://github.com/Laotree/verify-networking-plugin/releases/download/v0.1.0/verify-networking-0.1.0-macos.tar.gz"
  sha256 "23916277f7ab1c60862ac313a72845fb56f304dfb29f69b7525d084bf324d95c"
  version "0.1.0"

  def install
    bin.install "verify-networking"
  end

  test do
    assert_predicate bin/"verify-networking", :exist?
  end
end
