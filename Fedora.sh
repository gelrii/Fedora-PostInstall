#!/bin/bash

#Configure the GitHub user that the plugin scripts will be pulled from.
#This is useful if you have forked the script and intend to customise your own plugins.
gituser=asdf-git

yum install git -y
mkdir /tmp/postinst
cd /tmp/postinst
git clone -q https://github.com/asdf-git/Fedora-PostInstall.git
