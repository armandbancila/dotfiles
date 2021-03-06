# .bashrc
# source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f $HOME/.bash_exports ]; then
	. $HOME/.bash_exports
fi

if [ -f $HOME/.bash_aliases ]; then
	. $HOME/.bash_aliases
fi

if [ -f $HOME/.bash_functions ]; then
	. $HOME/.bash_functions
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# fzf
[ -f $HOME/.fzf.bash ] && source $HOME/.fzf.bash

