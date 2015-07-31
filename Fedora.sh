#!/bin/bash

#Configure the GitHub user that the plugin scripts will be pulled from.
#This is useful if you have forked the script and intend to customise your own plugins.
gituser=ajhaydock

rm -rf /tmp/FedPo
cd /tmp
git clone -q https://github.com/$gituser/FedPo.git
echo `whoami` > /tmp/FedPo/user
sh /tmp/FedPo/Fedora$(rpm -E %fedora).sh
