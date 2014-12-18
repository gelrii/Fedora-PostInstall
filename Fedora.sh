#!/bin/bash

#Configure the GitHub user that the plugin scripts will be pulled from.
#This is useful if you have forked the script and intend to customise your own plugins.
gituser=asdf-git

sudo yum install git -y
cd /tmp
git clone -q https://github.com/$gituser/Fedora-PostInstall.git
sudo sh /tmp/Fedora-PostInstall/Fedora$(rpm -E %fedora).sh
