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

Built from source on all platforms; requires Rust as a build dependency — Homebrew installs Rust automatically if needed.

Repository: [logs-locally-plugin](https://github.com/Laotree/logs-locally-plugin)

```bash
brew install Laotree/homebrew-tap/llp
```
