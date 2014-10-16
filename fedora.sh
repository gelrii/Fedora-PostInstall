#!/bin/bash

# Skeleton script to load a particular postinstall
# script version depending on your Fedora version.

# For now, it is simply hardcoded to download the
# F20 script.

curl -o /tmp/fedora.sh https://raw.githubusercontent.com/asdf-git/Fedora-PostInstall/master/fedora20.sh
chmod +x /tmp/fedora20.sh
sudo sh /tmp/fedora20.sh
