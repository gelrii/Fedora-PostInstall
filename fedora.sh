#!/bin/bash

# Skeleton script to load a particular postinstall
# script version depending on your Fedora version.

echo "This script will now attempt to check for and download"
echo "a compatible Fedora PostInstall script for your version of Fedora."
echo ""
echo "If the download fails, then unfortunately there is probably"
echo "no script available for your Fedora version yet."

curl -o /tmp/fedora$(rpm -E %fedora).sh https://raw.githubusercontent.com/asdf-git/Fedora-PostInstall/master/fedora$(rpm -E %fedora).sh
sudo sh /tmp/fedora$(rpm -E %fedora).sh
