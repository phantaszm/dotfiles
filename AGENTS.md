# Dotfiles Repository

This is a dotfiles repository using the [bare git repo pattern](https://www.atlassian.com/git/tutorials/dotfiles) for managing configurations.

## Setup

Run `.bin/dgit-install.sh` to install, and again later to update. It clones the repo to `~/.dotfiles`
(or fast-forwards an existing clone), checks out configs to `$HOME`, and then, for each tool that is
present, installs fisher and the fish plugins, builds bat's theme cache and installs the tmux plugins.
Skipped steps are printed as tips at the end.
The repo's own `README.md`, `CLAUDE.md` and `AGENTS.md` are excluded from that checkout (sparse checkout), so
they don't apply to every project under `$HOME`; read them in the source clone.

## Structure

- `.bin/` - executable scripts
- `.config/fish/` - fish shell config
- `.config/git/config` - git behaviour (no identity; ansible writes that to `~/.gitconfig`)
- `.config/nvchad-custom/` - neovim config (NvChad v2.5 plus local customisations)
- `.config/nvchad-starter/` - NvChad starter template (submodule, reference only)
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
