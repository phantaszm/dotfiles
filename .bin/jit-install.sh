#!/usr/bin/env bash
set -xeuo pipefail

DOTFILES_REPO="https://github.com/phantaszm/dotfiles.git"
DOTFILES_DIR="${HOME}/.dotfiles"
BACKUP_DIR="${HOME}/.dotfiles-backup"

jit() {
  git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" "$@"
}

init_dotfiles() {
  if [[ -d "$DOTFILES_DIR" ]]; then
    echo "dotfiles repo already exists at $DOTFILES_DIR"
    return 0
  fi

  echo "Cloning dotfiles repository..."
  git clone --bare feature/claude "$DOTFILES_REPO" "$DOTFILES_DIR"
}

backup_conflicting() {
  local conflicting
  conflicting=$(jit checkout 2>&1 | awk '/^\s/{print $1}' || true)

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

  if ! jit checkout 2>/dev/null; then
    backup_conflicting
    jit checkout
  fi

  jit config status.showUntrackedFiles no
  jit submodule update --init --recursive

  echo '===
For a nicer experience:
  * set shell theme using `theme_name` like `base16-tomorrow-night`
  * install fish modules with `fisher update`
  * install tmux plugins using <PREFIX>+I'
}

main "$@"
