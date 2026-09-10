# Prompt. Replaces matchai/spacefish, which was archived in 2021.
# Starship is a binary rather than a fisher plugin, so it is installed by the
# ansible base_system role -- from pacman on Arch, from a pinned GitHub release
# on Ubuntu. Not available on Debian 12, hence the guard: hosts without it fall
# back to fish's built-in prompt rather than erroring on every shell.
if status --is-interactive
    and command -v starship >/dev/null
    starship init fish | source
end
