# Page man output through bat for syntax highlighting. MANPAGER runs on every
# `man` call, so a missing bat would break man outright rather than just losing
# colour -- hence the guard. Debian and Ubuntu package bat as `batcat`, so fall
# back to that name; with neither, man keeps its default pager.
if command -v bat >/dev/null
    set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
else if command -v batcat >/dev/null
    set -x MANPAGER "sh -c 'col -bx | batcat -l man -p'"
end
