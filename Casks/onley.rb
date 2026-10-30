cask "onley" do
  arch arm: "arm64", intel: "x64"

  version "0.2.10"
  sha256 arm:   "5e8f4f5f62dd68f435b4a8c0693377e9d67231a3b6c22c1654549b3905d43cb7",
         intel: "1115be8663517c2560bd6d1f0a1efc8f225d3e4e49f80f33f938598b46dccc68"

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
