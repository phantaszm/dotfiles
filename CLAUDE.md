# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Pattern

This is a **bare git dotfiles repo**. The repo itself lives at `~/.dotfiles`; configs are checked out directly into `$HOME`. There is no build step, no symlinking, and no package manager for the configs themselves.

The `dgit` command (fish function + installer alias) wraps `git --git-dir="$HOME/.dotfiles" --work-tree="$HOME"` for day-to-day dotfiles management:

```bash
dgit status
dgit add .config/some/file
dgit commit -S -m "message"   # commits are GPG-signed
dgit push
```

When working in this source clone (`~/src/dotfiles`), use regular `git` — `dgit` is only needed once the repo is deployed to `~/.dotfiles`.

## Branching Model

Git Flow is in use: `main`, `develop`, feature branches (`feature/*`), hotfix branches (`hotfix/*`), and release branches (`release/*`). Fish abbreviations for this workflow: `gffs`/`gfff` (feature), `gfhs`/`gfhf` (hotfix), `gfrs`/`gfrf` (release).

## Installation

```bash
.bin/dgit-install.sh   # clone bare repo to ~/.dotfiles, checkout to $HOME, init submodules
```

Post-install (interactive, run in fish):
```fish
fisher update                      # sync fish plugins to fish_plugins
# In tmux: <Ctrl-a>+I             # install tmux plugins via TPM
```

`fisher update` both installs listed plugins and **removes ones no longer in
`fish_plugins`** — it is what actually uninstalls a dropped plugin's functions
from a host.

## Key Configs and Where They Live

| Tool | Path |
|------|------|
| Fish shell | `.config/fish/` |
| Fish abbreviations (git shorts) | `.config/fish/conf.d/git-shorts.fish` |
| Neovim (NvChad v2.5) | `.config/nvim/` (submodule) + `.config/nvchad-custom/` |
| Tmux | `.config/tmux/tmux.conf` |
| Vim fallback | `.vimrc` |
| Bat themes | `.config/bat/` |
| Silicon | `.config/silicon/` |

## Shell Tooling

Fish plugins are listed in `.config/fish/fish_plugins` and managed by fisher:

| Plugin | Purpose |
|--------|---------|
| `laughedelic/pisces` | Paired-symbol handling |
| `PatrickF1/fzf.fish` | fzf keybindings (replaced the dormant `jethrokuan/fzf`) |

**Do not add `jorgebucaran/fisher` to this file.** Fisher does not list itself,
and rewrites `fish_plugins` without that line every time it runs. Tracking it
makes the file diverge on every host after the first `fisher update`, which
then breaks the ansible dotfiles role — its `merge --ff-only` correctly refuses
to overwrite the local change. Fisher bootstraps from the tracked
`functions/fisher.fish` and `completions/fisher.fish`; it needs no entry here.

Three tools are **binaries, not plugins**, installed by the ansible repo's
`base_system` role. Each has a guarded file in `conf.d/` so a host without the
binary falls through silently instead of erroring on every shell:

| Tool | File | Replaced |
|------|------|----------|
| starship | `conf.d/starship.fish` | `matchai/spacefish` (archived 2021) |
| zoxide | `conf.d/zoxide.fish` | `jethrokuan/z` |
| eza | `conf.d/eza.fish` | `gazorby/fish-exa` (wrapped the dead `exa`) |

Debian 12 packages none of the three, so hosts on it keep fish's built-in
prompt and no `ll` alias. That is expected, not a misconfiguration.

## Submodules

Two submodules are tracked:
- `.config/tmux/plugins/tpm` → tmux-plugins/tpm
- `.config/nvim` → NvChad/starter

`.config/base16-shell` was removed: shell palettes are now the terminal's job,
and upstream had been dormant since 2024.

After pulling changes that touch submodules: `git submodule update --init --recursive`.

## Neovim Setup

NvChad v2.5 is the base (`.config/nvim/` submodule). Custom overrides live exclusively in `.config/nvchad-custom/` — do not modify files inside `.config/nvim/` directly. Plugins include: fugitive, lspconfig, none-ls (null-ls replacement), undotree, vim-tmux-navigator.

## Tmux

Prefix is `Ctrl-a`. TPM manages plugins (dracula theme, vim-tmux-navigator, resurrect, continuum). Mouse support is on; history limit is 30,000 lines.
