# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Pattern

This is a **bare git dotfiles repo**. The repo itself lives at `~/.dotfiles`; configs are checked out directly into `$HOME`. There is no build step, no symlinking, and no package manager for the configs themselves.

The `jit` command (fish function + installer alias) wraps `git --git-dir="$HOME/.dotfiles" --work-tree="$HOME"` for day-to-day dotfiles management:

```bash
jit status
jit add .config/some/file
jit commit -S -m "message"   # commits are GPG-signed
jit push
```

When working in this source clone (`~/src/dotfiles`), use regular `git` — `jit` is only needed once the repo is deployed to `~/.dotfiles`.

## Branching Model

Git Flow is in use: `main`, `develop`, feature branches (`feature/*`), hotfix branches (`hotfix/*`), and release branches (`release/*`). Fish abbreviations for this workflow: `gffs`/`gfff` (feature), `gfhs`/`gfhf` (hotfix), `gfrs`/`gfrf` (release).

## Installation

```bash
.bin/jit-install.sh   # clone bare repo to ~/.dotfiles, checkout to $HOME, init submodules
```

Post-install (interactive, run in fish):
```fish
theme_name base16-tomorrow-night   # set base16 color theme
fisher update                      # install fish plugins
# In tmux: <Ctrl-a>+I             # install tmux plugins via TPM
```

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

## Submodules

Three submodules are tracked:
- `.config/base16-shell` → chriskempson/base16-shell
- `.config/tmux/plugins/tpm` → tmux-plugins/tpm
- `.config/nvim` → NvChad/starter

After pulling changes that touch submodules: `git submodule update --init --recursive`.

## Neovim Setup

NvChad v2.5 is the base (`.config/nvim/` submodule). Custom overrides live exclusively in `.config/nvchad-custom/` — do not modify files inside `.config/nvim/` directly. Plugins include: fugitive, lspconfig, none-ls (null-ls replacement), undotree, vim-tmux-navigator.

## Tmux

Prefix is `Ctrl-a`. TPM manages plugins (dracula theme, vim-tmux-navigator, resurrect, continuum). Mouse support is on; history limit is 30,000 lines.
