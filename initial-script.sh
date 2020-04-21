#!/bin/sh

# Ask for the administrator password upfront
sudo -v

# utilities
#source ./utils.sh

# ----------------------------------
ARROW="→"
CHECK="✔"
CLOSE="✗"

function msg() {
	echo " \033[0;37m$1\033[0m";
}

function msg_bold() {
	echo " \033[1;34m$1\033[0m";
}

function msg_ok() {
	echo " $ARROW\033[1;32m  $1 $CHECK\033[0m";
}

# ----------------------------------

# Upgrade
sudo apt-get update &> /dev/null
msg_ok "update"

sudo apt-get upgrade -y &> /dev/null
msg_ok "upgrade"

sudo apt-get dist-upgrade -y &> /dev/null
msg_ok "dist-upgrade"


# Git
if has_not git; then
	sudo apt-get install -y \
		git \
		git-core
	git config --global user.name "Marlon Klagenberg"
    git config --global user.email "marlon.klc@gmail.com"
fi
msg_ok "git"


# ZSH
if ! which zsh &> /dev/null; then
	sudo apt-get install zsh -y
	chsh -s $(which zsh)
fi
msg_ok "zsh"


# clone setup repository
#if ! [[ -d "$HOME/.setup" ]]; then
#    git clone https://github.com/marlonklc/my-ubuntu-setup.git $HOME/.setup
#fi
#msg_ok "setup"

# Finished
msg ""
msg_ok "Finished"
msg ""
msg " --- Log out and login back again to use your new default shell..."
msg ""
