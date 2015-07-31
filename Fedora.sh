#!/bin/bash

#Configure the GitHub user that the plugin scripts will be pulled from.
#This is useful if you have forked the script and intend to customise your own plugins.
gituser=gelrii

rm -rf /tmp/Fedora-Postinstall
cd /tmp
git clone -q https://github.com/$gituser/Fedora-Postinstall.git
echo `whoami` > /tmp/Fedora-Postinstall/user
sh /tmp/Fedora-Postinstall/Fedora$(rpm -E %fedora).sh
