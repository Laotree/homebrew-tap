cask "onley" do
  arch arm: "arm64", intel: "x64"

  version "0.2.4"
  sha256 arm:   "b97457e40b59ddbe9ad7d200f5c78e765db76c318d163a530907ffe48742eccf",
         intel: "9b77be57d48d9ef8b1acf72b5a2a2e028b4b158e3642dcc6eccf0b6e5d1f1a7c"

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

  caveats <<~EOS
    Onley is not signed or notarized. On first launch, right-click Onley.app
    in Applications and choose Open, or allow it in System Settings >
    Privacy & Security.
  EOS
end
