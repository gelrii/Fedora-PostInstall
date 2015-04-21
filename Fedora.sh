#!/bin/bash

#Configure the GitHub user that the plugin scripts will be pulled from.
#This is useful if you have forked the script and intend to customise your own plugins.
gituser=gelrii

rm -rf /tmp/Fedora-PostInstall
cd /tmp
git clone -q https://github.com/$gituser/Fedora-PostInstall.git
echo `whoami` > /tmp/Fedora-PostInstall/user
sudo sh /tmp/Fedora-PostInstall/Fedora$(rpm -E %fedora).sh
