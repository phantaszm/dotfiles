# Dotfiles Repository

This is a dotfiles repository using the [bare git repo pattern](https://www.atlassian.com/git/tutorials/dotfiles) for managing configurations.

## Setup

Run `.bin/dgit-install.sh` to install. It clones the repo to `~/.dotfiles` and checks out configs to `$HOME`.

Post-install steps:
- Set fish theme: `theme_name base16-tomorrow-night`
- Install fish plugins: `fisher update`
- Install tmux plugins: `<PREFIX>+I` (prefix is Ctrl-a by default)

## Structure

- `.bin/` - executable scripts
- `.config/fish/` - fish shell config
- `.config/nvim/` - neovim config (NvChad-based)
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
