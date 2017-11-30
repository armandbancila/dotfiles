# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
## import
if [ -f ~/.bash_exports ]; then
	. ~/.bash_exports
fi

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

if [ -f ~/.bash_functions ]; then
	. ~/.bash_functions
fi

## functions
### extract common archive formats
extract () {
	if [ -f "$*" ] ; then
		case "$*" in
			*.tar.bz2) tar xvjf "$*";;
			*.tar.gz)  tar xvzf "$*";;
			*.bz2)     bunzip2 "$*";;
			*.rar)     unrar x "$*";;
			*.gz)      gunzip "$*";;
			*.tar)     tar xvf "$*";;
			*.tbz2)    tar xvjf "$*";;
			*.tgz)     tar xvzf "$*";;
			*.zip)     unzip "$*";;
			*.Z)       uncompress "$*";;
			*.7z)      7za x "$*";;
			*)         echo "Unrecognized extension: '$*'...";;
		esac
	else
		echo "Invalid file: '$*'"
	fi
}

### grep for process
psgrep() {
	if [ ! -z $1 ] ; then
		echo "Grepping for processes matching $1..."
		ps aux | grep $1 | grep -v grep
	else
		echo "!! Need name to grep for"
	fi
}

### take ownership of directory
seize() {
	sudo chown -R ${USER} ${1:-.}
}

### dirsize - finds directory sizes and lists them for the current directory
dirsize() {
	du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
	egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
	egrep '^ *[0-9.]*M' /tmp/list
	egrep '^ *[0-9.]*G' /tmp/list
	rm -rf /tmp/list
}

### roll an n-sided dice
roll() {
	echo $(python -c "import random; print(random.randint(1, ${1:-6}))")
}

### take notes, move to dir, pull then push and take a filename as parameter
### if filename param is present, append timestamp to file and open it in vim
tn() {
	cd ~/Documents/notes
	./sync.sh
	if [ ! -z "$1" ]; then
		echo -e "\n# note taken on $(date --rfc-3339='seconds') $(date +%s)\n" >> $1
		vimx "+ normal G$" +startinsert $1
	fi
}

### return number of jobs
jobscount() {
  local stopped=$(jobs -sp | wc -l)
  local running=$(jobs -rp | wc -l)
  ((running+stopped)) && echo -n "${running}r/${stopped}s "
}

## terminal colors and prompt
### __git_ps1
source /usr/share/git-core/contrib/completion/git-prompt.sh
#### or run "git config bash.showDirtyState false"
#### nonempty, it's slow in large repos
export GIT_PS1_SHOWDIRTYSTATE=1
### shell colors in urxvt with gruvbox theme
#### setaf foreground, setab background, set color using ANSI escape
MEDIUM_BLACK="$(tput setaf 235)"
BLACK="$(tput setaf 0)"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
PURPLE="$(tput setaf 5)"
AQUA="$(tput setaf 6)"
LIGHT_GREY="$(tput setaf 7)"
DARK_GREY="$(tput setaf 8)"
LIGHT_RED="$(tput setaf 9)"
LIGHT_GREEN="$(tput setaf 10)"
LIGHT_YELLOW="$(tput setaf 11)"
LIGHT_BLUE="$(tput setaf 12)"
LIGHT_PURPLE="$(tput setaf 13)"
LIGHT_AQUA="$(tput setaf 14)"
WHITE="$(tput setaf 15)"
RESET="$(tput sgr0)" # reset all colors, returns '\e[0m'
### colored prompt
force_color_prompt=yes
### export these for subshells
### export -f parse_git_branch parse_git_status we_are_in_git_work_tree
#### PS1
##### time
PS1='\[${DARK_GREY}\]$(date +%H:%M:%S) '
##### username and host
PS1=${PS1}'\[${LIGHT_YELLOW}\]\u@\h '
##### current working directory
PS1=${PS1}'\[${BLUE}\]\w '
##### git prompt
PS1=${PS1}'\[${LIGHT_PURPLE}\]$(__git_ps1 "(%s) ")'
##### jobs
PS1=${PS1}'\[${LIGHT_RED}\]$(jobscount)'
##### end
PS1=${PS1}'\[${YELLOW}\]\$ \[${RESET}\]'
export PS1
export PS2='> '
export PS3='> '
export PS4='#? '
### enable color support of ls
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
### ls colors
LS_COLORS=$LS_COLORS:'ex=1;92:di=1;34:tw=1;34:ow=1;34:' ; export LS_COLORS
### colored GCC warnings and errors
#### default
#### export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

## enable programmable completion features (you don't need to enable
## this, if it's already enabled in /etc/bash.bashrc and /etc/profile
## sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

## history
### don't put duplicate lines or lines starting with space in the history.
### See bash(1) for more options
HISTCONTROL=ignoreboth
### ignore ls without options and builtin commands
export HISTIGNORE="&:ls:[bf]g:exit"
### append to the history file, don't overwrite it
shopt -s histappend
### combine multiline commands into one in history
shopt -s cmdhist
### for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1048576                   # big big history
export HISTFILESIZE=1073741824              # big big history
### export HISTCONTROL=ignoredups:erasedups # no duplicate entries
### export HISTIGNORE=' *'                  # ignore commands matching re
### check the window size after each command and, if necessary,
### update the values of LINES and COLUMNS.
### Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

## general aliases
alias ls='ls --color=auto --group-directories-first'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
### unix timestamp
#### alias ts='date +%s'
### generate random secret
alias generate-secret='echo "$(date +%Y%m%d):$(openssl rand -base64 30)"'
### windows-style clear terminal (for real)
alias cls='printf "\033c"'
### v = verbose
### recursive
alias cp='cp -vr'
### inform of overwrite
alias mv='mv -vi'
### recursive, force
alias rm='rm -vrf'
### pretty rg
alias rg='rg -p'
### make parents as needed
alias mkdir='mkdir -vp'
alias du='du -hs'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
### vim compiled with clipboard support
alias vim='vimx'
### use clipboard
alias xclip='xclip -selection clipboard'
### matlab
alias matlab='/usr/local/MATLAB/R2017b/bin/matlab'
### increase stack size in scala
alias scala='scala -J-Xss1024m'
### uni folders
alias cfl='cd ~/Documents/courses/y3/t1/cfl'
alias cis='cd ~/Documents/courses/y3/t1/cis'
alias cov='cd ~/Documents/courses/y3/t1/cov'
alias prj='cd ~/Documents/courses/y3/t1/prj'
# misc
alias def='sdcv'
alias space='ls -d */ | xargs -I item du -hs item'
alias diff='diff --color -u'

## sdcv variables
export STARDICT_DATA_DIR='~/.stardict/dic'
export SDCV_PAGER='less'

## set default terminal editor (for sudoedit)
export EDITOR='vimx'

## configure less pager
### set default terminal pager
export PAGER='less'
### set options for less
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'
### colored less for man pages
export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\e[01;38;5;214m' # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\e[38;5;142m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export LESS_TERMCAP_us=$'\e[04;38;5;208m' # begin underline
export GROFF_NO_SGR=1                     # for konsole and gnome-terminal

## cowsay
export COWPATH="/usr/share/cowsay"
### set COWPATH so it includes user's cows
if [ -d "$HOME/.cowsay" ] ; then
    COWPATH="$COWPATH:$HOME/.cowsay"
fi

## added by Anaconda3 4.4.0 installer
export PATH="/home/armand/anaconda3/bin:$PATH"

