# my-ubuntu-setup
configure my apps and ubuntu (theme, configs)

### How to use

First thing execute initial commands below to install 'curl':
```
$ sudo apt update
$ sudo apt upgrade
$ sudo apt install curl
```

After that execute this command below to install git, zsh and create setup folder:
```
curl -o- https://raw.githubusercontent.com/marlonklc/my-ubuntu-setup/master/initial-script.sh | bash
```

When finished it, do logout and login back again in your account to use your new default shell.

After that execute last command that start the setup script:
```
bash ~/.my-ubuntu-setup/setup.sh
```
