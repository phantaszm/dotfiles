# Defined in - @ line 1
function jit --wraps='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' --description 'alias jit git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
  git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $argv;
end
