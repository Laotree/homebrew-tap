cask "onley" do
  arch arm: "arm64", intel: "x64"

  version "0.2.16"
  sha256 arm:   "ebebf200bda3abf923d6c95baa7ca6fa9a71983f906d7ec1d0d9c0ebeaaede38",
         intel: "0802b113db61b979c511409f37b25d3d459d796f4c656a790e8f54bd3ef8e0dd"

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
