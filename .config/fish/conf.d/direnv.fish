# direnv is installed by the ansible base_system role, but the guard keeps a
# host without it from erroring on every interactive shell.
if status --is-interactive
    and command -v direnv >/dev/null
    direnv hook fish | source
end
