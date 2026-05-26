#!/usr/bin/env python3
"""
Update a Homebrew formula to a new version.

Usage:
    python3 scripts/update_formula.py <formula> <version>

    formula  – verify-networking | session-score-plugin | llp
    version  – new version string, with or without leading 'v' (e.g. 0.3.0 or v0.3.0)
"""

import hashlib
import re
import sys
import urllib.request
from pathlib import Path

# ── Formula registry ───────────────────────────────────────────────────────────

FORMULAS: dict[str, dict] = {
    "verify-networking": {
        "file": "Formula/verify-networking.rb",
        "type": "single",
        # {v} is substituted with the bare version (no leading 'v')
        "url": (
            "https://github.com/Laotree/verify-networking-plugin"
            "/releases/download/v{v}/verify-networking-{v}-macos.tar.gz"
        ),
    },
    "session-score-plugin": {
        "file": "Formula/session-score-plugin.rb",
        "type": "dual",
        "arm64_url": (
            "https://github.com/Laotree/session-score-plugin"
            "/releases/download/v{v}/session-score-plugin-v{v}-aarch64-apple-darwin.tar.gz"
        ),
        "intel_url": (
            "https://github.com/Laotree/session-score-plugin"
            "/archive/refs/tags/v{v}.tar.gz"
        ),
    },
    "llp": {
        "file": "Formula/llp.rb",
        "type": "source",
        "url": (
            "https://github.com/Laotree/logs-locally-plugin"
            "/archive/refs/tags/v{v}.tar.gz"
        ),
    },
}

# ── Helpers ────────────────────────────────────────────────────────────────────

def sha256_of_url(url: str) -> str:
    """Download *url* and return its SHA-256 hex digest."""
    print(f"  Fetching  {url}")
    req = urllib.request.Request(url, headers={"User-Agent": "Homebrew/brew"})
    with urllib.request.urlopen(req) as resp:
        digest = hashlib.sha256(resp.read()).hexdigest()
    print(f"  sha256    {digest}")
    return digest


def rewrite_block(text: str, block_keyword: str, new_url: str, new_sha: str) -> str:
    """Replace the url/sha256 inside the first `<block_keyword> do … end` block."""
    def replacer(m: re.Match) -> str:
        blk = m.group(0)
        blk = re.sub(r'(url ")[^"]+(")', rf'\g<1>{new_url}\g<2>', blk)
        blk = re.sub(r'(sha256 ")[^"]+(")', rf'\g<1>{new_sha}\g<2>', blk)
        return blk

    return re.sub(
        rf'{re.escape(block_keyword)} do.*?end',
        replacer,
        text,
        count=1,
        flags=re.DOTALL,
    )

# ── Per-formula updaters ───────────────────────────────────────────────────────

def update_single(version: str, cfg: dict) -> None:
    """verify-networking — one URL + sha256 + version field."""
    url = cfg["url"].format(v=version)
    sha = sha256_of_url(url)

    path = Path(cfg["file"])
    text = path.read_text()
    text = re.sub(r'(url ")[^"]+(")',    rf'\g<1>{url}\g<2>',     text)
    text = re.sub(r'(sha256 ")[^"]+(")', rf'\g<1>{sha}\g<2>',     text)
    text = re.sub(r'(version ")[^"]+(")',rf'\g<1>{version}\g<2>', text)
    path.write_text(text)


def update_dual(version: str, cfg: dict) -> None:
    """session-score-plugin — ARM64 binary + Intel source, independent url/sha256."""
    arm64_url = cfg["arm64_url"].format(v=version)
    intel_url = cfg["intel_url"].format(v=version)
    arm64_sha = sha256_of_url(arm64_url)
    intel_sha = sha256_of_url(intel_url)

    path = Path(cfg["file"])
    text = path.read_text()

    # Update the version field (appears once at the top of the formula)
    text = re.sub(r'(version ")[^"]+(")', rf'\g<1>{version}\g<2>', text)

    # Update url/sha256 inside each architecture block
    text = rewrite_block(text, "on_arm",   arm64_url, arm64_sha)
    text = rewrite_block(text, "on_intel", intel_url, intel_sha)

    path.write_text(text)


def update_source(version: str, cfg: dict) -> None:
    """llp — source tarball for all platforms; rewrite to canonical tarball form."""
    url = cfg["url"].format(v=version)
    sha = sha256_of_url(url)

    # Rewrite the whole formula so it uses a clean tarball stanza
    # (migrating away from the git-revision approach used in v0.2.0)
    new_content = (
        'class Llp < Formula\n'
        '  desc "Read Claude Code session JSONL files and persist them to a local SQLite database"\n'
        '  homepage "https://github.com/Laotree/logs-locally-plugin"\n'
        f'  url "{url}"\n'
        f'  sha256 "{sha}"\n'
        f'  version "{version}"\n'
        '  license "MIT"\n'
        '\n'
        '  depends_on "rust" => :build\n'
        '\n'
        '  def install\n'
        '    system "cargo", "install", *std_cargo_args\n'
        '  end\n'
        '\n'
        '  test do\n'
        '    assert_match version.to_s, shell_output("#{bin}/llp --version")\n'
        '  end\n'
        'end\n'
    )
    Path(cfg["file"]).write_text(new_content)


UPDATERS = {
    "single": update_single,
    "dual":   update_dual,
    "source": update_source,
}

# ── Main ───────────────────────────────────────────────────────────────────────

def main() -> None:
    if len(sys.argv) != 3:
        print(f"Usage: {sys.argv[0]} <formula> <version>", file=sys.stderr)
        print(f"  Formulas: {', '.join(FORMULAS)}", file=sys.stderr)
        sys.exit(1)

    formula = sys.argv[1]
    version = sys.argv[2].lstrip("v")   # tolerate both "0.3.0" and "v0.3.0"

    if formula not in FORMULAS:
        print(f"Unknown formula '{formula}'.", file=sys.stderr)
        print(f"Known formulas: {', '.join(FORMULAS)}", file=sys.stderr)
        sys.exit(1)

    cfg = FORMULAS[formula]
    print(f"Updating {formula} → v{version}")
    UPDATERS[cfg["type"]](version, cfg)
    print(f"✓ {cfg['file']} updated")


if __name__ == "__main__":
    main()
