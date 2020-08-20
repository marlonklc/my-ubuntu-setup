#!/bin/sh

hello

# General installs
sudo apt-get install -y \
    software-properties-common \
	build-essential \
    htop \
	indicator-multiload \
	preload \
	smbclient \
	ubuntu-restricted-extras \
	unity-tweak-tool \
	vim \
	xclip \
	jq > /dev/null

msg "######## Common packages #########"
msg ""
msg_ok "software-properties-common"
msg_ok "build-essential"
msg_ok "htop" # more visual than command "top"
msg_ok "indicator-multiload"
msg_ok "preload" # perform a better indexing of search files 
msg_ok "smbclient" # client samba
msg_ok "ubuntu-restricted-extras"
msg_ok "unity-tweak-tool"
msg_ok "vim"
msg_ok "xclip"
msg_ok "jq"
msg ""
msg "###################################"
msg ""

msg "updating ..."
sudo apt-get update &> /dev/null
msg_ok "updated"


msg ""
msg "######## My personal apps #########"
msg ""


# Chrome web browser
if has_not google-chrome; then
    msg "installing google chrome ..."
    wget -O ~/Downloads/google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb > /dev/null
    sudo apt install ~/Downloads/google-chrome.deb -y > /dev/null
    rm ~/Downloads/google-chrome.deb > /dev/null
fi
msg_ok "google chrome installed"


# Dbeaver
if has_not dbeaver; then
    msg "installing dbeaver ..."
    echo "deb https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list > /dev/null
	wget -O - https://dbeaver.io/debs/dbeaver.gpg.key | sudo apt-key add - > /dev/null
	sudo apt-get update > /dev/null
	sudo apt-get install dbeaver-ce -y > /dev/null
fi
msg_ok "dbeaver installed"


# Docker
if has_not docker; then
    msg "installing docker ..."
	sudo apt-get update &> /dev/null
    sudo apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common > /dev/null
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - > /dev/null
    sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable" > /dev/null
	sudo apt-get update &> /dev/null
	sudo apt-get install -y docker-ce docker-ce-cli containerd.io > /dev/null
	sudo systemctl start docker
    sudo systemctl enable docker
	sudo groupadd docker
	sudo usermod -aG docker ${USER}
fi
msg_ok "docker installed"


# Java
if has_not java; then
    msg "installing openjdk-8 ..."
	sudo add-apt-repository ppa:openjdk-r/ppa -y > /dev/null
	sudo apt-get update &> /dev/null
	sudo apt-get install -y openjdk-8-jdk > /dev/null
fi
msg_ok "openjdk-8 installed"


# node, nvm, npm
if has_not_dir "$HOME/.nvm"; then
    msg "installing node, nvm, npm ..."
    sudo apt-get update &> /dev/null
    sudo apt-get install -y build-essential libssl-dev > /dev/null
	curl https://raw.githubusercontent.com/creationix/nvm/v0.35.3/install.sh &> /dev/null | bash > /dev/null
    echo 'export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion' >> ~/.zshrc
	source ~/.zshrc
	nvm install npm &> /dev/null
	nvm install node &> /dev/null
	nvm use node &> /dev/null
	nvm alias default node &> /dev/null

	npm i -g \
		npm &> /dev/null
fi
msg_ok "nvm, node, npm installed"


# Oh My ZSH (framework for managing your zsh configuration)
if has_not_dir "$HOME/.oh-my-zsh"; then
    msg "installing oh-my-zsh ..."
	chsh -s /usr/bin/zsh
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" > /dev/null

	# Plugins
	git clone https://github.com/wbinglee/zsh-wakatime.git ~/.custom/plugins/zsh-wakatime > /dev/null
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.custom/plugins/zsh-syntax-highlighting > /dev/null

	# Themes
	wget https://raw.githubusercontent.com/dracula/zsh/master/dracula.zsh-theme -O ~/.custom/themes/dracula.zsh-theme > /dev/null
fi
msg_ok "oh-my-zsh installed"


# Pip3 (python dependencies manager)
if has_not pip3; then
    msg "installing pip3 ..."
	sudo apt-get install -y python3-pip > /dev/null
fi
msg_ok "pip3 installed"


# IntelliJ IDE
if has_not intellij-idea-community; then
    msg "installing intellij ..."
    sudo snap install intellij-idea-community --classic -y &> /dev/null
fi
msg_ok "intellij installed"


# VS Code
if has_not code; then
    msg "installing vscode ..."
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    curl https://packages.microsoft.com/keys/microsoft.asc &> /dev/null | gpg --dearmor > microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo apt-get update &> /dev/null
    sudo apt-get install code -y &> /dev/null

    # install extensions
    code --install-extension vscjava.vscode-java-pack &> /dev/null # java pack
    code --install-extension pivotal.vscode-boot-dev-pack &> /dev/null # spring pack
fi
msg_ok "vscode installed"


msg ""
msg "###################################"
msg ""


msg "Cleaning packages not used..."
# Cleanup
sudo apt-get purge \
	aisleriot \
	gnome-mahjongg \
	gnome-mines &> /dev/null

sudo apt-get autoclean &> /dev/null -y
sudo apt-get autoremove &> /dev/null -y

msg_ok "successful cleaning!!!"

source ~/.zshrc

msg ""

