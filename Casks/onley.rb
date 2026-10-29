cask "onley" do
  arch arm: "arm64", intel: "x64"

  version "0.2.7"
  sha256 arm:   "5202fe4344cc627b408648a3f733025d0c8faefbb7ac0c005e366ec86859bab6",
         intel: "ac42932de2b5fa21defcefb05ef88df40ac9a05bcdadfe984528b9fba7d14e60"

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
