alias def='sdcv'
alias space='ls -d */ | xargs -I item du -hs item'
alias diff='diff --color -u'
alias du='du -hs'
alias deldupes='fdupes -rdN'
alias delemptydirs='find . -type d -empty -delete'
alias gifify='convert -delay 5 -loop 0'
alias diffw='diff -w -B'
alias tmux='tmux -2' # force 256 colors
alias sudo='sudo '
alias ls='ls --color=auto --group-directories-first'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
# fix the terminal
alias cls="printf 'a\033c'"
# remove the annoying cookie prompts
alias lynx='lynx -cookies -accept_all_cookies'
# verbose recursive
alias cp='cp -vr'
# inform of overwrite
alias mv='mv -vi'
# recursive, force
alias rm='rm -vrf'
# rg output for piping
alias rgl='rg --color always'
alias rgp='rg -iN --no-messages'
# make parents as needed
alias mkdir='mkdir -vp'
alias gl='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit'
# vim compiled with clipboard support
alias vim='vimx'
alias v='vimx'
# use clipboard
alias xclip='xclip -selection clipboard'
alias matlab='/usr/local/MATLAB/R2019b/bin/matlab'
# increase stack size in scala
alias scala='scala -J-Xss1024m'
alias s='scala'
alias p='python'
