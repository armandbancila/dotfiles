# .bash_profile

# export vblank_mode=0

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin
export PATH
# export FZF_DEFAULT_COMMAND='rg'

# xcalib -c
# xcalib -red 1 1 100 -alter
# xcalib -green 1 1 90 -alter
# xcalib -blue 1 1 90 -alter
if [ -e /home/armand/.nix-profile/etc/profile.d/nix.sh ]; then . /home/armand/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
