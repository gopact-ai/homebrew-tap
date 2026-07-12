# Homebrew Tap for NineA

This is the official Homebrew tap for
[NineA](https://github.com/gopact-ai/9a), the capability layer that exposes MCP
tools, A2A agents, and HTTP APIs as filesystem-native Skills.

## Install

```sh
brew install gopact-ai/tap/ninea
```

The formula installs both the `9a` client and the `ninead` daemon. It supports
macOS and Linux on x86-64 and ARM64.

## Upgrade

```sh
brew update
brew upgrade gopact-ai/tap/ninea
```

Formula updates are generated from NineA's published release checksums and
tested on macOS and Linux before they merge.

NineA and this tap are available under the [MIT License](LICENSE).
