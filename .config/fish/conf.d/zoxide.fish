# Directory jumping. Replaces jethrokuan/z.
#
# --cmd cd makes `cd` itself zoxide-backed: a real directory argument behaves
# exactly like builtin cd, and anything else falls back to a frecency jump.
# `cdi` gives interactive selection. This is what Omarchy's bash `zd` function
# does by hand; zoxide implements it natively and also handles `cd -`.
#
# Note --cmd needs zoxide >= 0.5; Debian 12 ships 0.4.3, which is why zoxide is
# not installed there and this guard matters.
if status --is-interactive
    and command -v zoxide >/dev/null
    zoxide init fish --cmd cd | source
end
