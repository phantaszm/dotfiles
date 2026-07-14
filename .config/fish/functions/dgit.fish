# Defined in - @ line 1
function dgit --wraps='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' --description 'alias dgit git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
  git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $argv;
end
