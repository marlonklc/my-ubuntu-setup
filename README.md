# my-ubuntu-setup
This project allow me install my personal apps, configure my ubuntu (themes, configs, etc) so fast.

### How to use

First thing execute initial commands below to install 'curl':
```
$ sudo apt update
$ sudo apt upgrade
$ sudo apt install curl
```

After that execute this command below to install git, zsh and create setup folder:
```
$ curl -o- https://raw.githubusercontent.com/marlonklc/my-ubuntu-setup/master/initial-script.sh | bash
```

When finished it, you need logout and login back again in your account to use your new default shell.

After that execute last command to start the setup:
```
$ cd ~/.my-ubuntu-setup
$ zsh ./setup.sh
```

So, that's it !
