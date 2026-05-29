# Laotree/homebrew-tap

Homebrew tap for tools and plugins from [Laotree](https://github.com/Laotree).

## Tap Installation

```bash
brew tap Laotree/homebrew-tap
```

## Formulas

| Formula | Version | Description |
|---|---|---|
| [verify-networking](#verify-networking-v010) | v0.1.0 | Network connectivity checker for Claude Code/Codex sessions |
| [session-score-plugin](#session-score-plugin-v010) | v0.1.0 | Score and analyse Claude Code sessions |
| [llp](#llp-logs-locally-plugin-v020) | v0.2.0 | Persist Claude Code session logs to SQLite |

---

### verify-networking (v0.1.0)

Network connectivity checker that runs before Claude Code/Codex sessions.

Distributed as a pre-built macOS binary — no build dependencies required.

Repository: [verify-networking-plugin](https://github.com/Laotree/verify-networking-plugin)

```bash
brew install Laotree/homebrew-tap/verify-networking
```

---

### session-score-plugin (v0.1.0)

Score, analyse, and improve your Claude Code sessions.

On Apple Silicon (ARM64), a pre-built binary is installed. On Intel Macs, the formula builds from source and requires Rust as a build dependency — Homebrew installs Rust automatically if needed.

Repository: [session-score-plugin](https://github.com/Laotree/session-score-plugin)

```bash
brew install Laotree/homebrew-tap/session-score-plugin
```

---

### llp (logs-locally-plugin, v0.2.0)

Read Claude Code session JSONL files and persist them to a local SQLite database.

Distributed as a pre-built, stripped binary (macOS ARM64/x86_64, Linux x86_64) — no build dependencies required.

Repository: [logs-locally-plugin](https://github.com/Laotree/logs-locally-plugin)

```bash
brew install Laotree/homebrew-tap/llp
```

---

## Auto-Deploy

When a new tag is pushed to any source repo, the Homebrew formula is updated
automatically via the [`update-formula`](.github/workflows/update-formula.yml)
GitHub Actions workflow in this tap.

### How it works

1. A release workflow in the source repo calls `gh workflow run` (or sends a
   `repository_dispatch` event) to this tap, passing the formula name and new
   version.
2. The tap workflow downloads the release assets, computes their SHA-256
   checksums, updates the relevant `.rb` formula, and commits straight to
   `main`.

### Setup in each source repo

1. Create a [Fine-Grained PAT](https://github.com/settings/tokens) scoped to
   `Laotree/homebrew-tap` with **Contents: Read & Write** and **Actions: Write**
   permissions. Store it as a secret named `HOMEBREW_TAP_TOKEN` in the source
   repo.

2. Add the following workflow (adjust `formula` to match the repo):

```yaml
# .github/workflows/release.yml  (add this job, or append to an existing one)
name: Release

on:
  push:
    tags:
      - 'v*'

jobs:
  notify-tap:
    runs-on: ubuntu-latest
    needs: [build]          # run after your build/publish job if you have one
    steps:
      - name: Trigger Homebrew tap update
        env:
          GH_TOKEN: ${{ secrets.HOMEBREW_TAP_TOKEN }}
        run: |
          VERSION="${GITHUB_REF_NAME#v}"   # strip leading 'v'
          gh workflow run update-formula.yml \
            --repo Laotree/homebrew-tap \
            --field formula=<FORMULA_NAME> \
            --field version="$VERSION"
```

Replace `<FORMULA_NAME>` with one of: `verify-networking`, `session-score-plugin`, `llp`.

The workflow can also be triggered manually from the
[Actions tab](../../actions/workflows/update-formula.yml) of this tap repo.
