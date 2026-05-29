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
        "type": "binary",
        # Prebuilt, stripped binaries attached to the GitHub Release by
        # logs-locally-plugin's release-binaries.yml workflow.
        "arm64_macos_url": (
            "https://github.com/Laotree/logs-locally-plugin"
            "/releases/download/v{v}/llp-aarch64-apple-darwin.tar.gz"
        ),
        "x86_64_macos_url": (
            "https://github.com/Laotree/logs-locally-plugin"
            "/releases/download/v{v}/llp-x86_64-apple-darwin.tar.gz"
        ),
        "x86_64_linux_url": (
            "https://github.com/Laotree/logs-locally-plugin"
            "/releases/download/v{v}/llp-x86_64-unknown-linux-gnu.tar.gz"
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


def update_binary(version: str, cfg: dict) -> None:
    """llp — prebuilt stripped binary per platform; no from-source build."""
    arm64_macos_url  = cfg["arm64_macos_url"].format(v=version)
    x86_64_macos_url = cfg["x86_64_macos_url"].format(v=version)
    x86_64_linux_url = cfg["x86_64_linux_url"].format(v=version)
    arm64_macos_sha  = sha256_of_url(arm64_macos_url)
    x86_64_macos_sha = sha256_of_url(x86_64_macos_url)
    x86_64_linux_sha = sha256_of_url(x86_64_linux_url)

    new_content = (
        'class Llp < Formula\n'
        '  desc "Read Claude Code session JSONL files and persist them to a local SQLite database"\n'
        '  homepage "https://github.com/Laotree/logs-locally-plugin"\n'
        f'  version "{version}"\n'
        '  license "MIT"\n'
        '\n'
        '  on_macos do\n'
        '    on_arm do\n'
        f'      url "{arm64_macos_url}"\n'
        f'      sha256 "{arm64_macos_sha}"\n'
        '    end\n'
        '    on_intel do\n'
        f'      url "{x86_64_macos_url}"\n'
        f'      sha256 "{x86_64_macos_sha}"\n'
        '    end\n'
        '  end\n'
        '\n'
        '  on_linux do\n'
        '    on_intel do\n'
        f'      url "{x86_64_linux_url}"\n'
        f'      sha256 "{x86_64_linux_sha}"\n'
        '    end\n'
        '  end\n'
        '\n'
        '  def install\n'
        '    bin.install "llp"\n'
        '  end\n'
        '\n'
        '  test do\n'
        '    assert_match version.to_s, shell_output("#{bin}/llp version")\n'
        '  end\n'
        'end\n'
    )
    Path(cfg["file"]).write_text(new_content)


UPDATERS = {
    "single": update_single,
    "dual":   update_dual,
    "binary": update_binary,
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
