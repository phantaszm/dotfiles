#!/usr/bin/env bash
# Bootstrap or update the bare-repo dotfiles checkout in $HOME.
#
# First run: clone --bare into ~/.dotfiles, check the tree out over $HOME
# (backing up files that would be overwritten), then do the setup the files
# alone cannot: fisher and its plugins, the bat theme cache, tmux plugins.
# Later runs: fast-forward to the remote branch and redo that setup, so this
# script is also the update command on a machine ansible does not manage.
# Ansible-managed hosts get the same steps from the tech-ansible dotfiles
# role; do not run this there.
set -euo pipefail

DOTFILES_REPO="https://github.com/phantaszm/dotfiles.git"
DOTFILES_DIR="${HOME}/.dotfiles"
BACKUP_DIR="${HOME}/.dotfiles-backup"
BRANCH="${1:-main}"
FISHER_VERSION="4.4.8"

dgit() {
  git --git-dir="$DOTFILES_DIR" --work-tree="$HOME" "$@"
}

tips=()

init_dotfiles() {
  if [[ -d "$DOTFILES_DIR" ]]; then
    echo "dotfiles repo already exists at $DOTFILES_DIR"
    return 0
  fi

  echo "Cloning dotfiles repository..."
  git clone --bare --branch "$BRANCH" "$DOTFILES_REPO" "$DOTFILES_DIR"
}

# The remote the branch tracks, if any, else origin. The Mac's checkout, for
# one, calls its remote "github". `git clone --bare` sets no fetch refspec,
# so without one a fetch would fill only FETCH_HEAD and <remote>/<branch>
# would never exist.
configure_remote() {
  REMOTE=$(dgit config "branch.${BRANCH}.remote" || echo origin)
  dgit config "remote.${REMOTE}.fetch" "+refs/heads/*:refs/remotes/${REMOTE}/*"
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

checkout_dotfiles() {
  if ! dgit checkout 2>/dev/null; then
    backup_conflicting
    dgit checkout
  fi
}

# --ff-only never rewrites local history or drops local edits: a diverged
# checkout fails here, loudly, and nothing below runs.
update_dotfiles() {
  echo "Updating dotfiles from ${REMOTE}/${BRANCH}..."
  dgit fetch --prune "$REMOTE"
  (cd "$HOME" && dgit merge --ff-only "${REMOTE}/${BRANCH}")
}

# fisher owns its own files (the repo stopped tracking them in 0.20.0), so a
# new machine needs it fetched once; after that `fisher update` syncs
# fish_plugins, removing dropped plugins too. </dev/null is load-bearing:
# fisher reads plugin names from stdin whenever stdin is not a terminal and
# blocks until EOF.
setup_fisher() {
  if ! command -v fish >/dev/null; then
    tips+=("install fish, then rerun this script (or in fish: curl -fsSL https://raw.githubusercontent.com/jorgebucaran/fisher/${FISHER_VERSION}/functions/fisher.fish | source && fisher update)")
    return 0
  fi
  if [[ -f "${HOME}/.config/fish/functions/fisher.fish" ]]; then
    echo "Syncing fish plugins..."
    fish -c 'fisher update' </dev/null
  else
    echo "Installing fisher ${FISHER_VERSION} and fish plugins..."
    fish -c "curl -fsSL https://raw.githubusercontent.com/jorgebucaran/fisher/${FISHER_VERSION}/functions/fisher.fish | source && fisher update" </dev/null
  fi
}

# conf.d/bat.fish names a theme from .config/bat/themes, which bat only
# knows after `bat cache --build`. Debian and Ubuntu call the binary batcat.
setup_bat() {
  local bat theme missing=0
  bat=$(command -v bat || command -v batcat || true)
  if [[ -z "$bat" ]]; then
    tips+=("install bat, then run: bat cache --build (batcat on Debian/Ubuntu), so BAT_THEME resolves")
    return 0
  fi
  for theme in "${HOME}"/.config/bat/themes/*.tmTheme; do
    [[ -e "$theme" ]] || continue
    theme=$(basename "$theme" .tmTheme)
    if ! "$bat" --list-themes | grep -qx "$theme"; then
      missing=1
    fi
  done
  if [[ $missing = 1 ]]; then
    echo "Building the bat theme cache..."
    "$bat" cache --build >/dev/null
  fi
}

# tpm's headless installer does what <PREFIX>+I does. It reads the config
# with `tmux start-server; show-option`, and this tmux.conf opens a session
# on server start, so stop the server afterwards -- only if this script
# started it. A server already running keeps its session; tpm then talks to
# that one, which is the same as pressing <PREFIX>+I in it.
setup_tmux() {
  local installer="${HOME}/.config/tmux/plugins/tpm/bin/install_plugins"
  [[ -x "$installer" ]] || return 0
  if ! command -v tmux >/dev/null; then
    tips+=("install tmux, then install its plugins with <PREFIX>+I")
    return 0
  fi
  local was_running=1
  tmux list-sessions >/dev/null 2>&1 || was_running=0
  echo "Installing tmux plugins..."
  "$installer" | grep -v 'Already installed' || true
  if [[ $was_running = 0 ]]; then
    tmux kill-server >/dev/null 2>&1 || true
  fi
}

main() {
  local fresh=1
  [[ -d "$DOTFILES_DIR" ]] && fresh=0

  init_dotfiles
  configure_remote
  configure_sparse

  if [[ $fresh = 1 ]]; then
    checkout_dotfiles
  else
    update_dotfiles
  fi

  dgit config status.showUntrackedFiles no
  # Submodule commands need the working tree as cwd, unlike the rest of dgit.
  (cd "$HOME" && dgit submodule update --init --recursive)

  setup_fisher
  setup_bat
  setup_tmux

  if [[ ${#tips[@]} -gt 0 ]]; then
    echo '===
Not done, for lack of the tool:'
    printf '  * %s\n' "${tips[@]}"
  fi
}

main
