#!/usr/bin/env bash
if [ ! -d "$HOME/.dotfiles" ]; then
  git clone --bare https://github.com/phantaszm/dotfiles.git "$HOME"/.dotfiles
else
  echo "dotfiles repo already exists"
fi
function jit {
  /usr/bin/git --git-dir="$HOME"/.dotfiles/ --work-tree="$HOME" "$@"
}
# This backup logic isn't very good
#if ! jit checkout; then
#  echo "Checked out config.";
#else
#  mkdir -p .dotfiles-backup
#  echo "Backing up pre-existing dot files.";
#  jit checkout 2>&1 | grep -E "\s+\." | awk "{'print $2'}" | xargs -I{} mv {} .dotfiles-backup/{}
#  jit checkout
#fi;
jit checkout
jit config status.showUntrackedFiles no
jit submodule update --init --recursive

echo '''===
For a nicer experience:
  * set shell theme using `theme_name` like `base16-tomorrow-night`
  * install fish modules with `fisher update`,
  * install tmux theme using `<PREFIX>+I`
'''
