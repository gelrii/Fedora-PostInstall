#!/bin/bash

# Skeleton script to load a particular postinstall
# script version depending on your Fedora version.

# For now, it is simply hardcoded to download the
# F20 script.

/bin/echo "This script will now attempt to check for and download
a compatible Fedora PostInstall script for your version of Fedora.

If the download fails, then unfortunately there is currently
no script available for your Fedora version."

curl -o /tmp/fedora.sh https://raw.githubusercontent.com/asdf-git/Fedora-PostInstall/master/fedora$(rpm -E %fedora).sh
chmod +x /tmp/fedora$(rpm -E %fedora).sh
sudo sh /tmp/fedora$(rpm -E %fedora).sh
