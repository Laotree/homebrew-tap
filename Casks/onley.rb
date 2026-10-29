cask "onley" do
  arch arm: "arm64", intel: "x64"

  version "0.2.5"
  sha256 arm:   "280f179aafaf0bfcd40a20a2e77c191185041a44e313dd2256b50c1d5c6c559d",
         intel: "5870cd07f26cb236d486d84be9afe0aeb87842a5cea1a0f94132f03fbb6927aa"

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
