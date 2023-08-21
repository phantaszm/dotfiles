abbr -a -g gci  git commit -S -m
abbr -a -g gst  git status
abbr -a -g gdf  git diff
abbr -a -g gbr  git branch -a
abbr -a -g gco  git checkout
abbr -a -g gcod git checkout develop
abbr -a -g gcom git checkout main
abbr -a -g gcor git checkout release/sprint
abbr -a -g ggpg set -x GPG_TTY (tty)

abbr -a -g gffs git flow feature start
abbr -a -g gfff git flow feature finish #(git branch --show-current | awk -F'/' '{print $2}')
abbr -a -g gfhs git flow hotfix start
abbr -a -g gfhf git flow hotfix finish #(git branch --show-current | awk -F'/' '{print $2}')
abbr -a -g gfrs git flow release start
abbr -a -g gfrf git flow release finish #(git branch --show-current | awk -F'/' '{print $2}')
