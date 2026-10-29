cask "onley" do
  arch arm: "arm64", intel: "x64"

  version "0.2.6"
  sha256 arm:   "46cb6eb93c3cf58e8b2f608ebcc809b31c7b8a98eb9718b999fc612096149d7b",
         intel: "d501c6165282c289fda70b4037e22320e4d0b682455f848e97f58b7e9fa43102"

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
