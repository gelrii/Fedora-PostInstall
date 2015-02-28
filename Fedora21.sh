#!/bin/bash
continue=1

# Set some variables
version="4.1" # Increment major changes here, and update datecode when necessary
fvsupp="21" # Fedora release version this script targets
luser=$(< /tmp/Fedora-PostInstall/user) #Set the identity of the user who launched the script. Will be useful later.

# Ensure script is being run as root
if (( $EUID != 0 )); then
/bin/echo "This script must be run as root. Type in 'sudo $0' to run it as root."
exit 1
fi

# Fedora Version Check
if (( $(rpm -E %fedora) != $fvsupp )); then
/bin/echo "This script is optimised for Fedora $fvsupp.
It may not run correctly on earlier/later versions of Fedora.
To force the script to run on this system, please remove the
\"Fedora Version Check\" section of the script, and attempt
to run the script again."
exit 1
fi

#Tell the script to look in the current directory
#and append the name of the plugins directory
#dir="$(dirname "$0")/Plugins"
dir="$(dirname "$0")/$fvsupp/plugins"

#Specify plugins here
. $dir/Start
. $dir/Main
. $dir/Exit
. $dir/Enable_RPMFusion
. $dir/Desktop_Environment
. $dir/Remove_KDE_Packages
. $dir/Remove_Gnome_Packages
. $dir/System_Update
. $dir/Installer
. $dir/Install_Packages
. $dir/Install_NVIDIA
. $dir/Enable_SSH
. $dir/Install_ZoL
. $dir/Hosts_Block
. $dir/Fix_Fonts
. $dir/Install_ownCloud
. $dir/Install_POL
. $dir/Install_Chrome
. $dir/Install_HTPC
. $dir/Dotfiles
. $dir/Minimal_Setup
. $dir/VM_Guest
. $dir/AutoUpdate

until [ $continue = 0 ]; do
	Start
exit
done
