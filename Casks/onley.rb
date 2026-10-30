cask "onley" do
  arch arm: "arm64", intel: "x64"

  version "0.2.11"
  sha256 arm:   "8c171208d14407eb20efd7949e7e0299e123cad63e3aeb646c24cccdb0ad719c",
         intel: "7cac0a449039c47767505117c2123ef1e45b14195be1335f94bf19401f6ac1a7"

  url "https://github.com/fdaio/onley/releases/download/v#{version}/onley-desktop_v#{version}_macos_#{arch}.zip"
  name "Onley"
  desc "Local file deduplication tool"
  homepage "https://github.com/fdaio/onley"

  livecheck do
    url "https://github.com/fdaio/onley/releases/latest"
    strategy :github_latest
  end

  depends_on :macos

  app "Onley.app"

  zap trash: "~/.onley"
end
