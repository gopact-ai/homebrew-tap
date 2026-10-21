# gopact-ai Homebrew Tap

Official Homebrew formulas for gopact-ai projects:

- [NineA](https://github.com/gopact-ai/9a): a local capability runtime that lets
  AI agents connect, search, and run HTTP APIs, MCP tools, and A2A agents.
- [Steve](https://github.com/gopact-ai/steve): self-hosted delegation, follow-up
  and records for the coding agents you already use.

## Steve

```sh
brew install gopact-ai/tap/steve
steve init
```

The formula installs `steve` and `steve-node` for macOS and Linux on x86-64 and
ARM64.

## NineA

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

The tap is available under the [MIT License](LICENSE). Steve is licensed under Apache-2.0.
