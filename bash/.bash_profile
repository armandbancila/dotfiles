# .bash_profile

export vblank_mode=0

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin
export PATH
export FZF_DEFAULT_COMMAND='rg'


