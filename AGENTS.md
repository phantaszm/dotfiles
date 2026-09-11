# Dotfiles Repository

This is a dotfiles repository using the [bare git repo pattern](https://www.atlassian.com/git/tutorials/dotfiles) for managing configurations.

## Setup

Run `.bin/dgit-install.sh` to install. It clones the repo to `~/.dotfiles` and checks out configs to `$HOME`.

Post-install steps:
- Install fisher once, then sync plugins (in fish): `curl -fsSL https://raw.githubusercontent.com/jorgebucaran/fisher/4.4.8/functions/fisher.fish | source && fisher update`
  (afterwards, plain `fisher update` syncs to `fish_plugins`, removing dropped plugins)
- Install tmux plugins: `<PREFIX>+I` (prefix is Ctrl-a by default)

## Structure

- `.bin/` - executable scripts
- `.config/fish/` - fish shell config
- `.config/nvchad-starter/` - NvChad starter template (submodule, reference only)
- `.config/nvim-scratch/` - standalone lazy.nvim config
  (no `.config/nvim` is deployed; symlink one of the above to activate it)
- `.config/tmux/` - tmux config
- `.vimrc` - vim config (fallback for systems without neovim)

## Key Commands

```bash
# Using the dotfiles git alias (defined in dgit-install.sh)
dgit status
dgit add .config/some/file
dgit commit -m "update"
dgit push
```
