cask "onley" do
  arch arm: "arm64", intel: "x64"

  version "0.2.9"
  sha256 arm:   "3e85036eb86f49f8cd55a951183d1018589a5bd32ad476a97b8c9713bcc7fc7c",
         intel: "dda262c1569078f70cedd9c89ea53916e61cca3e140cad3971b55d82311dfcdd"

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
