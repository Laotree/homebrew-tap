cask "onley" do
  arch arm: "arm64", intel: "x64"

  version "0.2.8"
  sha256 arm:   "2802ac5166221fd1ea4358ad87bdc7a1e70bcc623b43aa3a02ca06a76952f6b6",
         intel: "4c96367e8adabdb1bcdae427b90221b821724161adb02c809c2a0fe8c0ae3414"

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
