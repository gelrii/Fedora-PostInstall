#!/bin/bash
curl -o /home/`whoami`/.bashrc https://raw.githubusercontent.com/asdf-git/dotfiles/master/.bashrc
curl -o /home/`whoami`/.bash_aliases https://raw.githubusercontent.com/asdf-git/dotfiles/master/.bash_aliases
curl -o /home/`whoami`/.systeminfo.sh https://raw.githubusercontent.com/asdf-git/dotfiles/master/.systeminfo.sh
curl -o /home/`whoami`/.update.sh https://raw.githubusercontent.com/asdf-git/dotfiles/master/.update.sh
