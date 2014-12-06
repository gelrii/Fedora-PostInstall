#!/bin/bash

# Skeleton script to load a particular postinstall
# script version depending on your Fedora version.

fv=$(rpm -E %fedora)

echo "This script will now attempt to check for and download"
echo "a compatible Fedora PostInstall script for your version of Fedora."
echo ""
echo "If the download fails, then unfortunately there is probably"
echo "no script available for your Fedora version yet."

curl -o /tmp/fedora$fv.sh https://raw.githubusercontent.com/asdf-git/Fedora-PostInstall/master/fedora$fv.sh
chmod +x /tmp/fedora$fv.sh
sudo sh /tmp/fedora$fv.sh
