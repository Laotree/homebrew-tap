cask "onley" do
  arch arm: "arm64", intel: "x64"

  version "0.2.2"
  sha256 arm:   "fd3f62472335443d7326a419c81d166ccaea4a787659888a1daa9043eb3129a0",
         intel: "29a4ef0958542bf6fa54fb6f76bcc3f2c48c01f616fcbd8922b116805c547495"

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
