#!/bin/sh

# Ask for the administrator password upfront
sudo -v

# utilities
source <(curl -s https://raw.githubusercontent.com/marlonklc/my-ubuntu-setup/master/utils.sh)

# show banner
hello

# Upgrade
sudo apt-get update &> /dev/null
msg_ok "apt-get update"

sudo apt-get upgrade -y &> /dev/null
msg_ok "apt-get upgrade"

sudo apt-get dist-upgrade -y &> /dev/null
msg_ok "apt-get dist-upgrade"


# Git (distributed version control system)
if has_not git; then
	sudo apt-get install -y \
		git \
		git-core &> /dev/null
	git config --global user.name "Marlon Klagenberg"
    git config --global user.email "marlon.klc@gmail.com"
fi
msg_ok "git installed"


# ZSH (powerful command line interpreter for scripting languages)
if ! which zsh &> /dev/null; then
	sudo apt-get install zsh -y > /dev/null
	chsh -s $(which zsh) > /dev/null
fi
msg_ok "zsh installed"


# clone setup repository
rm -Rf $HOME/.my-ubuntu-setup
git clone https://github.com/marlonklc/my-ubuntu-setup.git $HOME/.my-ubuntu-setup &> /dev/null
msg_ok "cloned repository on github"

# Finished
msg ""
msg_ok "Finished"
msg ""
msg "--- Log out and login back again to use your new default shell..."
msg ""
