# general aliases
# alias dnf='dnf -C'
alias def='sdcv'
alias space='ls -d */ | xargs -I item du -hs item'
alias diff='diff --color -u'
alias du='du -hs'
alias deldupes='fdupes -rdN ./'
alias delemptydirs='find . -type d -empty -delete'
alias gifify='convert -delay 5 -loop 0'
alias dirlines='find . -name \'\''*\'\'' | xargs wc -l'
alias diffw='diff -w -B'
alias tmux='tmux -2' # force 256 colors
alias sudo='sudo '
alias dnf='dnf --cacheonly'
alias ls='ls --color=auto --group-directories-first'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
# windows-style clear terminal
alias cls='printf "\033c"'
# verbose recursive
alias cp='cp -vr'
# inform of overwrite
alias mv='mv -vi'
# recursive, force
alias rm='rm -vrf'
# rg output for piping
alias rgp='rg -iN --no-messages'
# make parents as needed
alias mkdir='mkdir -vp'
alias gl='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit'
# vim compiled with clipboard support
alias vim='vimx'
alias v='vimx'
# use clipboard
alias xclip='xclip -selection clipboard'
# matlab
alias matlab='/usr/local/MATLAB/R2017b/bin/matlab'
# increase stack size in scala
alias scala='scala -J-Xss1024m'
alias s='scala'
# python alias
alias p='python'
# uni folders
alias cfl='cd ~/Documents/courses/y3/t1/cfl'
alias cis='cd ~/Documents/courses/y3/t1/cis'
alias cov='cd ~/Documents/courses/y3/t1/cov'
alias pre='cd ~/Documents/courses/y3/t2/pre'
alias com='cd ~/Documents/courses/y3/t2/com'
alias ome='cd ~/Documents/courses/y3/t2/ome'
alias prj='cd ~/Documents/courses/y3/prj'

