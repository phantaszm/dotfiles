# Listing. Replaces gazorby/fish-exa, which wrapped exa -- a dead project
# superseded by eza -- and generated 80+ combinatorial aliases.
#
# Matches Omarchy's own alias so the two machines behave alike. ls is left
# alone deliberately; only ll is redefined.
if status --is-interactive
    and command -v eza >/dev/null
    alias ll='eza -lh --group-directories-first --icons=auto'
end
