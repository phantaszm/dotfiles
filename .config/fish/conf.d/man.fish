# Page man output through bat for syntax highlighting. MANPAGER runs on every
# `man` call, so a missing bat would break man outright rather than just losing
# colour -- hence the guard. Debian and Ubuntu package bat as `batcat`, so fall
# back to that name; with neither, man keeps its default pager.
#
# MANROFFOPT=-c makes groff emit backspace overstrikes, which `col -bx` strips,
# instead of ANSI colour codes, which it mangles into visible junk like
# "1mls 22m". Arch's groff defaults to colour codes; Debian's groff and macOS's
# mandoc already use overstrikes, so it changes nothing there.
if command -v bat >/dev/null
    set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
    set -x MANROFFOPT -c
else if command -v batcat >/dev/null
    set -x MANPAGER "sh -c 'col -bx | batcat -l man -p'"
    set -x MANROFFOPT -c
end
