# Homebrew Tap for NineA

This is the official Homebrew tap for
[NineA](https://github.com/gopact-ai/9a), the capability layer that exposes MCP
tools, A2A agents, and HTTP APIs as filesystem-native Skills.

## Install

```sh
brew install gopact-ai/tap/ninea
```

The formula installs one `9a` command. Normal commands start its local daemon
automatically, so no shell configuration or separate daemon command is needed.
It supports macOS and Linux on x86-64 and ARM64.

To keep the daemon running independently of a terminal session:

```sh
brew services start gopact-ai/tap/ninea
```

## Upgrade

```sh
brew update
brew upgrade gopact-ai/tap/ninea
```

Formula updates are generated from NineA's published release checksums, checked
daily for freshness, and tested on macOS and Linux before they merge.

NineA and this tap are available under the [MIT License](LICENSE).
