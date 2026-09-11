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
# fisher is not tracked here, so fetch it once, then sync fish_plugins:
curl -fsSL https://raw.githubusercontent.com/jorgebucaran/fisher/4.4.8/functions/fisher.fish | source && fisher update
# In tmux: <Ctrl-a>+I             # install tmux plugins via TPM
```

`fisher update` both installs listed plugins and **removes ones no longer in
`fish_plugins`** — it is what actually uninstalls a dropped plugin's functions
from a host.

On ansible-managed hosts the dotfiles role runs that bootstrap itself, pinned to
the same fisher tag. Afterwards, plain `fisher update` re-syncs to
`fish_plugins`.

## Key Configs and Where They Live

| Tool | Path |
|------|------|
| Fish shell | `.config/fish/` |
| Fish abbreviations (git shorts) | `.config/fish/conf.d/git-shorts.fish` |
| Neovim (real config) | `.config/nvim-mine/` |
| Neovim (NvChad starter, reference only) | `.config/nvchad-starter/` (submodule) |
| Neovim (scratch config) | `.config/nvim-scratch/` |
| Tmux | `.config/tmux/tmux.conf` |
| Vim fallback | `.vimrc` |
| Bat themes | `.config/bat/` |
| Silicon | `.config/silicon/` |

## Shell Tooling

Fish plugins are listed in `.config/fish/fish_plugins` and managed by fisher:

| Plugin | Purpose |
|--------|---------|
| `jorgebucaran/fisher` | The plugin manager itself — fisher manages its own files |
| `laughedelic/pisces` | Paired-symbol handling |
| `PatrickF1/fzf.fish` | fzf keybindings (replaced the dormant `jethrokuan/fzf`) |

**Fisher owns its own files; this repo must not track them.** Keep
`jorgebucaran/fisher` listed, and never commit `functions/fisher.fish` or
`completions/fisher.fish`. Until 0.20.0 the repo vendored both, which gave them
two owners and broke in both directions:

- **With the line listed**, `fisher update` tried to install itself, hit its own
  vendored files as a conflict (*"Cannot install … conflicting files"*),
  skipped itself, then rewrote `fish_plugins` without the line. The file
  diverged and the ansible dotfiles role's `merge --ff-only` refused to run.
- **With the line removed**, any machine where fisher had ever been registered
  treated it as an unlisted plugin and uninstalled it — deleting the vendored
  files and stopping before it installed anything else.

Fisher rewrites `fish_plugins` from the file's own entries, in their order and
case, keeping only the ones that registered. With nothing blocking fisher from
registering itself, the rewritten file matches the tracked one, so there is no
divergence.

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
- `.config/nvchad-starter` → NvChad/starter

`.config/base16-shell` was removed: shell palettes are now the terminal's job,
and upstream had been dormant since 2024.

After pulling changes that touch submodules: `git submodule update --init --recursive`.

## Neovim Setup

**There is deliberately no `.config/nvim` in this repo.** Nothing is deployed to
neovim's default config path, so plain `nvim` starts unconfigured unless you
create that symlink yourself on a given machine.

Three configs are tracked, none of them active by default:

| Path | What it is |
|------|-----------|
| `.config/nvim-mine/` | The real config: NvChad v2.5 plus local customisations. Tracked normally, freely editable |
| `.config/nvchad-starter/` | The NvChad starter template, as a submodule. Pristine upstream — treat it as read-only reference |
| `.config/nvim-scratch/` | A standalone lazy.nvim config, tracked normally and freely editable |

To use one, symlink or set `NVIM_APPNAME`:

```bash
ln -s ~/.config/nvim-mine ~/.config/nvim        # the usual choice
NVIM_APPNAME=nvim-scratch nvim                  # or run one ad hoc
```

The submodule was previously checked out at `.config/nvim`, which made it the
live config — so a `submodule update` could overwrite edits made there. Keeping
it at a non-default path removes that risk: editing the starter is now an
explicit act, not a side effect of using neovim.

`.config/nvim-mine/` carries what used to live untracked inside the submodule
checkout, so it now survives submodule work. Two customisations to know about:
`chadrc.lua` sets `theme = "tomorrow_night"` (matching the bat and silicon
themes), and `configs/lspconfig.lua` enables `pylsp`, `marksman`, `bashls`,
`terraformls` and `yamlls`. That LSP list was ported from the NvChad v2.0 API
to v2.5's `vim.lsp.enable`. `lazy-lock.json` is deliberately untracked (see
`.gitignore`): each machine keeps its own, so plugin versions are not pinned
across machines.

`.config/nvchad-custom/` was removed. It held NvChad v2.0-style overrides that
nothing had loaded since the v2.5 starter landed, and had been untouched since
January 2025 — its useful content is now in `nvim-mine`.

## Tmux

Prefix is `Ctrl-a`. TPM manages plugins (dracula theme, vim-tmux-navigator, resurrect, continuum). Mouse support is on; history limit is 30,000 lines.
