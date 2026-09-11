#!/usr/bin/env bash
set -euo pipefail

DOTFILES_REPO="https://github.com/phantaszm/dotfiles.git"
DOTFILES_DIR="${HOME}/.dotfiles"
BACKUP_DIR="${HOME}/.dotfiles-backup"
BRANCH="${1:-main}"

dgit() {
  git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" "$@"
}

init_dotfiles() {
  if [[ -d "$DOTFILES_DIR" ]]; then
    echo "dotfiles repo already exists at $DOTFILES_DIR"
    return 0
  fi

  echo "Cloning dotfiles repository..."
  git clone --bare --branch "$BRANCH" "$DOTFILES_REPO" "$DOTFILES_DIR"
}

# Keep the repo's own docs out of $HOME. They stay tracked, just not checked
# out: Claude Code reads CLAUDE.md from every parent directory, so a copy in
# $HOME applied to every project under it. Run before the first checkout so
# the files never land; on an older install it removes them (unless edited).
# git's own `sparse-checkout set`, not a hand-written config: git keeps the
# on/off setting in config.worktree, which overrides the main config.
# expectFilesOutsideOfPatterns keeps a pre-existing ~/README.md of your own
# from showing up as a modified tracked file. `dgit sparse-checkout disable`
# undoes it.
configure_sparse() {
  dgit config sparse.expectFilesOutsideOfPatterns true
  (cd "$HOME" && dgit sparse-checkout set --no-cone '/*' '!/README.md' '!/CLAUDE.md' '!/AGENTS.md')
}

backup_conflicting() {
  local conflicting
  conflicting=$(dgit checkout 2>&1 | awk '/^\s/{print $1}' || true)

  [[ -z "$conflicting" ]] && return 0

  echo "Backing up conflicting files to $BACKUP_DIR..."
  while IFS= read -r file; do
    local dest="${BACKUP_DIR}/${file}"
    mkdir -p "$(dirname "$dest")"
    mv "${HOME}/${file}" "$dest"
    echo "  backed up: $file"
  done <<< "$conflicting"
}

main() {
  init_dotfiles
  configure_sparse

  if ! dgit checkout 2>/dev/null; then
    backup_conflicting
    dgit checkout
  fi

  dgit config status.showUntrackedFiles no
  dgit submodule update --init --recursive

  echo '===
For a nicer experience:
  * install fisher and fish plugins (run in fish):
      curl -fsSL https://raw.githubusercontent.com/jorgebucaran/fisher/4.4.8/functions/fisher.fish | source && fisher update
  * install tmux plugins using <PREFIX>+I
  * build the bat theme cache so BAT_THEME (base16-tomorrow-night) resolves:
      bat cache --build        (batcat cache --build on Debian/Ubuntu)'
}

main
