cask "onley" do
  arch arm: "arm64", intel: "x64"

  version "0.2.3"
  sha256 arm:   "881b06e150fbed8237fc3b7e5ae757f1836766f84d71d99279129c3f2670f514",
         intel: "bcdf05fa380bda959141dc004162178d0776f7be6b2f50cf5937f2c41839c574"

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
