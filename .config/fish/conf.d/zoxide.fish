# Directory jumping. Replaces jethrokuan/z.
#
# Plain init gives zoxide's default commands: `z` for a frecency jump and `zi`
# for interactive selection, matching what jethrokuan/z provided. `cd` stays
# fish's builtin.
if status --is-interactive
    and command -v zoxide >/dev/null
    zoxide init fish | source
end
