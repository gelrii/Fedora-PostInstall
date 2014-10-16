#!/bin/bash

# Skeleton script to load a particular postinstall
# script version depending on your Fedora version.

/bin/echo "

This script will now attempt to check for and download
a compatible Fedora PostInstall script for your version of Fedora.

If the download fails, then unfortunately there is currently
no script available for your Fedora version.

"

curl -fsSL https://raw.githubusercontent.com/asdf-git/Fedora-PostInstall/master/fedora$(rpm -E %fedora).sh | sudo sh
