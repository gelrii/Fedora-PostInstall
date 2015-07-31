#!/bin/bash
continue=1

# Set some variables
script="7.1" # Increment major changes here
release="22" # Fedora release version this script targets
luser=$(< /tmp/Fedora-Postinstall/user) #Set the identity of the user who launched the script. Will be useful later.

#Tell the script to look in the current directory
#and append the name of the plugins directory
#dir="$(dirname "$0")/Plugins"
dir="$(dirname "$0")/$release/plugins"

#Specify plugins here
. $dir/ArcTheme
. $dir/AutoUpdate
. $dir/Dotfiles
. $dir/Enable_RPMFusion
. $dir/Enable_SSH
. $dir/Exit
. $dir/Fix_Fonts
. $dir/Hosts_Block
. $dir/Install_Chrome
. $dir/Install_HTPC
. $dir/Install_NVIDIA
. $dir/Install_ownCloud
. $dir/Install_Packages
. $dir/Install_POL
. $dir/Install_Steam
. $dir/Install_TBB
. $dir/Install_Tor
. $dir/Install_VBox
#. $dir/Install_ZoL ## Temporarily disabled
. $dir/Installer
. $dir/Main
. $dir/Minimal_Setup
. $dir/MPVConf
. $dir/Remove_Useless
. $dir/Start
. $dir/System_Update
. $dir/tbb
. $dir/VBox_Guest
. $dir/VM_Guest
. $dir/WindowButtons

# Fedora Version Check
if (( $(rpm -E %fedora) != $release )); then
/bin/echo "                  #####   WARNING   #####

       This script is optimised for Fedora $release.
It may not run correctly on earlier/later versions of Fedora.

            Are you sure you wish to continue?

                      [Y]es  /  [N]o"
echo -n "> "
read opt
case $opt in
	[Yy]* ) Start
	;;
	[Nn]* ) exit 1
	;;
	*) exit 1
	;;
esac
fi

until [ $continue = 0 ]; do
	Start
exit
done
