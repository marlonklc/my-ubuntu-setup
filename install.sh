#!/bin/sh

hello

# General installs
sudo apt-get install -y \
	build-essential \
	ca-certificates \
	apt-transport-https \
    htop \
	indicator-multiload \
	preload \
	smbclient \
	ubuntu-restricted-extras \
	unity-tweak-tool \
	vim \
	xclip \
	jq 

msg " -- General installs --"
msg_ok "build-essential"
msg_ok "ca-certificates"
msg_ok "apt-transport-https"
msg_ok "htop" # more visual than command "top"
msg_ok "indicator-multiload"
msg_ok "preload" # perform a better indexing of search files 
msg_ok "smbclient" # client samba
msg_ok "ubuntu-restricted-extras"
msg_ok "unity-tweak-tool"
msg_ok "vim"
msg_ok "xclip"
msg_ok "jq"

sudo apt-get update

# Chrome web browser
if has_not google-chrome; then
    wget -O ~/Downloads/google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install ~/Downloads/google-chrome.deb
    rm ~/Downloads/google-chrome.deb
fi
msg_ok "google chrome installed"


# Dbeaver
if has_not dbeaver; then
    echo "deb https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list
	wget -O - https://dbeaver.io/debs/dbeaver.gpg.key | sudo apt-key add -
	sudo apt-get update
	sudo apt-get install dbeaver-ce -y
fi
msg_ok "dbeaver installed"


# Docker
if has_not docker; then
	sudo apt-get update
	sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add –
    sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable" 
	sudo apt-get update
	sudo apt-get install docker-ce
	sudo systemctl start docker
    sudo systemctl enable docker
	sudo groupadd docker
	sudo usermod -aG docker $(whoami)
fi
msg_ok "docker installed"


# Java
if has_not java; then
	sudo add-apt-repository ppa:openjdk-r/ppa -y
	sudo apt-get update
	sudo apt-get install -y openjdk-8-jdk
fi
msg_ok "openjdk-8 installed"

exit

# node, nvm, npm
if has_not_dir "$HOME/.nvm"; then
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.35.3/install.sh | bash
	source ~/.zshrc
	nvm install node
	nvm use node
	nvm alias default node

	npm i -g \
		npm \
fi
msg_ok "nvm, node, npm installed"


# Oh My ZSH (framework for managing your zsh configuration)
if has_not_dir "$HOME/.oh-my-zsh"; then
	chsh -s /usr/bin/zsh
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

	# Plugins
	git clone https://github.com/wbinglee/zsh-wakatime.git ~/.custom/plugins/zsh-wakatime
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.custom/plugins/zsh-syntax-highlighting

	# Themes
	wget https://raw.githubusercontent.com/dracula/zsh/master/dracula.zsh-theme -O ~/.custom/themes/dracula.zsh-theme
fi
msg_ok "oh-my-zsh installed"


# Pip (python dependencies manager)
if has_not pip; then
	sudo apt-get install -y \
		python-dev \
		python-pip \
		python-software-properties

	sudo pip install --upgrade \
		pip \
		virtualenv

	sudo pip install \
		psutil \
		Pygments \
		thefuck \
		wakatime
fi
msg_ok "pip installed"


# Redshift (adjusts the color temperature of your screen to help your eyes hurt less)
if has_not redshift; then
	sudo apt-get install -y \
		redshift \
		redshift-gtk
fi
msg_ok "redshift installed"


# Rescuetime (track activities to time management)
if has_not rescuetime; then
	wget -O ~/Downloads/rescuetime.deb https://www.rescuetime.com/installers/rescuetime_current_amd64.deb
	sudo dpkg --force-depends -i ~/Downloads/rescuetime.deb
	sudo apt-get install -fy
	rm ~/Downloads/rescuetime.deb
fi
msg_ok "rescuetime"


# Shutter (great print screensaver)
if has_not shutter; then
	sudo apt-get -y install shutter
fi
msg_ok "shutter installed"


# Cleanup
sudo apt-get purge \
	aisleriot \
	gnome-mahjongg \
	gnome-mines

sudo apt-get autoclean &> /dev/null -y
sudo apt-get autoremove &> /dev/null -y

source ~/.zshrc

msg ""

