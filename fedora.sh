#!/bin/bash

# Fedora PostInstall Script
# v1.8.0 (20140831)

# Release Notes:
#     $a is a counter to allow the script to move from one while loop to another
#     $k is the KDE counter, $g is Gnome and $o is Other
#     $k, $g and $o are used in the Desktop_Environment section
#     $B is to change the colour of the text to blue, $T teal, $W white, $R resets colour
#     The order of the script is also controlled by the until loop at the end of the script
#     The name of each subroutine is a description of what is happening

# Proposed/Planned Changes:
#     - Move project to GitHub to allow one-line auto-download to work (PasteBin is breaking the script).
#     - Add desktop environment specific packages to be *installed* and not just removed.
#          - Install 'gnome-tweak-tools' for GNOME.
#     -    - Install 'gnome-disk-utility' for KDE (GUI frontend to gdisks - extremely useful! and does not need to pull in any other GNOME packages to work).
#     - Integrate a reboot after the initial system update and resume the script after rebooting (This allows the VirtualBox section to be re-added and an NVidia drivers section to be added.
#     - Migrate the script to the Crunchbang postinstall script style.
#     - Integrate support for automatically discovering what OS is running and running different scripts accordingly (a meta postinstall script).
#     - Integrate Google Chrome installation support for those that need Flash.
#     - Integrate automatic downloader for the latest Tor browser bundle. (Pipe the downloads.html page into curl and grep out the current 64-bit .tar.gz link?)

# Changelog:
#     v1.0.0 - Initial framework.
#     v1.0.1 - Fixed issue on line 1 that could cause problems when executing. Added version numbering.
#     v1.1.0 - Removed multiple uses of 'sudo' from within script. Whole script should instead be run as root. Fixed some wording. Added VirtualBox installation section.
#     v1.2.0 - Added an automatic /etc/hosts file updater.
#     v1.3.0 - Added Infinality installer for improved font rendering.
#     v1.3.1 - Fixed Infinality instaler.
#     v1.4.0 - Added assumeyes to all yum operations.
#     v1.5.0 - Added colourful ASCII to start of script.
#     v1.5.1 - Added reset of colour to ASCII. Placed added information on variables in release notes. 
#     v1.5.2 - Added colourful ASCII to end of script.
#     v1.5.3 - Fixed text of Infinality section.
#     v1.5.4 - Added 'unrar' to useful package installer.
#     v1.5.5 - Added 'cheese' to GNOME package remover.
#     v1.5.6 - Fixed /etc/hosts file installer.
#     v1.6.0 - Added installer for ownCloud Desktop Sync Client.
#     v1.7.0 - Added installer for PlayOnLinux.
#     v1.8.0 - Removed the VirtualBox section (causes issues installing before kernel update is complete) and replaced it with a ZFS on Linux install option.

a=1
k=0
g=0
o=0
B=$(tput setaf 4)
T=$(tput setaf 6)
W=$(tput setaf 7)
R=$(tput sgr0)

clear

echo "${B}  ###${R}                                 ${B}###${R}"
echo "${B} ### ${T}  ___         _                  ${B} ###${R}"
echo "${B}###  ${T} /  _| ___  _| | ___  _ __ __ _  ${B}  ###${R}"
echo "${B}###  ${T} | |_ / _ \/ ' |/   \| '__/ _' | ${B}  ###${R}"
echo "${B}###  ${T} |  _|  __/ (_)| (_) | | | (_| | ${B}  ###${R}"
echo "${B}###  ${T} |_|  \___|\_,_|\___/|_|  \__,_| ${B}  ###${R}"
echo "${B}###  ${R}                                 ${B}  ###${R}"
echo "${B} ### ${W}       Postinstall Script        ${B} ###${R}"
echo "${B}  ###${R}                                 ${B}###${R}"
echo " "
echo "       Please run this script as root."
echo "      Enter 'q' at any question to quit"


Enable_RPMFusion () {
        while [ $a = 1 ]; do
                echo " "
                echo "Enable Third-Party RPMFusion Repositories?"
                echo "     Y / N"
                echo " "
                read opt
                case $opt in
                        y) a=2
                        echo "Enabling RPMFusion Repositories."
                        yum -y localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
                        ;;
                        n) a=2
                        echo "Moving on."
                        ;;
                        q) a=0
                        echo "Exiting."
                        exit
                        ;;
        esac
done
}

Desktop_Environment () {
        while [ $a = 2 ]; do
                echo " "
                echo "What desktop environment are you using?"
                echo "KDE (k) / GNOME (g) / Other (o)"
                echo " "
                read opt
                case $opt in
                        k) k=1
                        a=3
                        Remove_KDE_Packages
                        ;;
                        g) g=1
                        a=3
                        Remove_Gnome_Packages
                        ;;
                        o) o=1
                        a=3
                        ;;
                        q) a=0
                        echo "Exiting."
                        exit
                        ;;
        esac
done
}

Remove_KDE_Packages () {
        while [ $k = 1 ]; do
                echo "You selected KDE as your desktop environment"
                echo "Remove (mostly) useless KDE packages?"
                echo "     Y / N"
                echo " "
                read opt
                case $opt in
                        y) k=0
                        echo "Removing packages..."
                        yum -y remove gwenview dragon amarok
                        echo "Removed useless KDE packages."
                        ;;
                        n) k=0
                        echo "Keeping all KDE packages."
                        ;;
                        q) k=0
                        a=0
                        echo "Exiting."
                        exit
                        ;;
                esac
done
}

Remove_Gnome_Packages () {
        while [ $g = 1 ]; do
                echo "You selected GNOME as your desktop environment."
                echo "Remove (mostly) useless GNOME packages?"
                echo "     Y / N"
                echo " "
                read opt
                case $opt in
                        y) g=0
                        echo "Removing packages..."
                        yum -y remove rhythmbox empathy totem evolution shotwell cheese
                        echo "Removed useless Gnome packages."
                        ;;
                        n) g=0
                        echo "Keeping all GNOME packages."
                        ;;
                        q) g=0
                        a=0
                        echo "Exiting."
                        exit
                        ;;
                esac
done
}

Update_Java () {
        while [ $a = 3 ]; do
                echo " "
                echo "Remove the OpenJDK 7 Java Runtime Environment and Install the OpenJDK 8 Java Runtime Environment?"
                echo "     ### Warning! ###"
                echo "This will also remove LibreOffice as it currently (Aug 2014) depends on Java7."
                echo "     Y / N"
                echo " "
                read opt
                case $opt in
                        y) a=4
                        echo "Updating your OpenJDK Java Runtime Environment."
                        yum -y remove java* && yum -y install java-1.8.0-openjdk
                        echo "Removed OpenJDK 7 JRE and installed OpenJDK 8 JRE."
                        ;;
                        n) a=4
                        echo "Moving on."
                        ;;
                        q) a=0
                        echo "Exiting."
                        exit
                        ;;
        esac
done
}

System_Update () {
        while [ $a = 4 ]; do
                echo " "
                echo "Update System?"
                echo "     Y / N"
                echo " "
                read opt
                case $opt in
                        y) a=5
                        echo "Updating System..."
                        yum -y update
                        echo "Updated System."
                        ;;
                        n) a=5
                        echo "Moving on."
                        ;;
                        q) a=0
                        echo "Exiting."
                        exit
                        ;;
        esac
done
}

Install_Packages () {
        while [ $a = 5 ]; do
                echo " "
                echo "Install a selection of useful packages?"
                echo "(Some of the packages are nonfree)"
                echo "     Y / N"
                echo " "
                read opt
                case $opt in
                        y) a=6
                        echo "Installing new packages..."
                        yum -y install htop nano xchat vlc lm_sensors iotop iftop gcc gnome-disk-utility firefox thunderbird keepass remmina-plugins-rdp ffmpeg mkvtoolnix youtube-dl eog recordmydesktop gpg gimp wget ntp unrar
                        echo "Installed new packages."
                        ;;
                        n) a=6
                        echo "Moving on."
                        ;;
                        q) a=0
                        echo "Exiting."
                        exit
                        ;;
        esac
done
}

Enable_SSH () {
        while [ $a = 6 ]; do
                echo " "
                echo "Enable and start SSH services?"
                echo "     Y / N"
                echo " "
                read opt
                case $opt in
                        y) a=7
                        echo "Enabling SSH services..."
                        systemctl enable sshd.service && systemctl start sshd.service && systemctl status sshd.service
                        echo "Enabled SSH services."
                        ;;
                        n) a=7
                        echo "Moving on."
                        ;;
                        q) a=0
                        echo "Exiting."
                        exit
                        ;;
        esac
done
}

Install_ZoL () {
        while [ $a = 7 ]; do
                echo " "
                echo "Install ZFS on Linux?"
                echo "     Y / N"
                echo " "
                read opt
                case $opt in
                        y) a=8
                        echo "Installing ZFS on Linux..."
                        sudo yum localinstall --nogpgcheck http://archive.zfsonlinux.org/fedora/zfs-release$(rpm -E %dist).noarch.rpm && sudo yum install kernel-devel zfs
                        echo "Installed ZFS on Linux."
                        ;;
                        n) a=8
                        echo "Moving on."
                        ;;
                        q) a=0
                        echo "Exiting."
                        exit
                        ;;
        esac
done
}

Hosts_Block () {
        while [ $a = 8 ]; do
                echo " "
                echo "Install custom hosts file to block ads/malicious IPs?"
                echo "     Y / N"
                echo " "
                read opt
                case $opt in
                        y) a=9
                        echo "Installing custom hosts file to /etc/hosts..."
                        cd /etc && rm /etc/hosts && sudo curl -C - -O http://someonewhocares.org/hosts/hosts
                        echo "Installed custom hosts file."
                        ;;
                        n) a=9
                        echo "Moving on."
                        ;;
                        q) a=0
                        echo "Exiting."
                        exit
                        ;;
        esac
done
}

Fix_Fonts () {
        while [ $a = 9 ]; do
                echo " "
                echo "Install Infinality to improve font rendering?"
                echo "     Y / N"
                echo " "
                read opt
                case $opt in
                        y) a=10
                        echo "Installing Infinality..."
# Note to script maintainers: The first command in the below line will need updating when the repo is updated.
# Check this page every so often to see if there have been updates: http://www.infinality.net/blog/infinality-repository/
                        rpm -Uvh http://www.infinality.net/fedora/linux/infinality-repo-1.0-1.noarch.rpm && yum -y install freetype-infinality fontconfig-infinality
                        echo "Installed Infinality. Changes to font rendering may not be visible until a reboot."
                        ;;
                        n) a=10
                        echo "Moving on."
                        ;;
                        q) a=0
                        echo "Exiting."
                        exit
                        ;;
        esac
done
}

Install_ownCloud () {
        while [ $a = 10 ]; do
                echo " "
                echo "Install ownCloud Desktop Sync Client?"
                echo "     Y / N"
                echo " "
                read opt
                case $opt in
                        y) a=11
                        echo "Installing ownCloud..."
                        cd /etc/yum.repos.d/ && wget http://download.opensuse.org/repositories/isv:ownCloud:desktop/Fedora_20/isv:ownCloud:desktop.repo && yum install owncloud-client
                        echo "Installed ownCloud."
                        ;;
                        n) a=11
                        echo "Moving on."
                        ;;
                        q) a=0
                        echo "Exiting."
                        exit
                        ;;
        esac
done
}

Install_POL () {
        while [ $a = 11 ]; do
                echo " "
                echo "Install PlayOnLinux?"
                echo "     Y / N"
                echo " "
                read opt
                case $opt in
                        y) a=12
                        echo "Installing PlayOnLinux..."
# Note to script maintainers: The first command in the below line will need updating when the repo is updated.
                        wget -O /tmp/playonlinux.rpm http://rpm.playonlinux.com/playonlinux-yum-4-1.noarch.rpm && yum -y install /tmp/playonlinux.rpm && yum -y install playonlinux
                        echo "Installed PlayOnLinux."
                        ;;
                        n) a=12
                        echo "Moving on."
                        ;;
                        q) a=0
                        echo "Exiting."
                        exit
                        ;;
        esac
done
}

until [ $a = 0 ]; do
        Enable_RPMFusion
        Desktop_Environment
        Update_Java
        System_Update
        Install_Packages
        Enable_SSH
        Install_ZoL
        Hosts_Block
        Fix_Fonts
        Install_ownCloud
        Install_POL
	echo " "
	echo "${B}            FFFFFFFFFFFF${R}"
	echo "${B}         FFFFFFFFFFFFFFFFFF${R}"
	echo "${B}        FFFFFFFFFF${W}#######${B}FFF${R}"
	echo "${B}       FFFFFFFFFF${W}#######${T}ff${B}FFF${R}"
	echo "${B}      FFFFFFFFFFF${W}##${B}FFFFF${T}fff${B}FFF${R}"
	echo "${B}     FFFFFFFFFFFF${W}##${B}FFFFFF${T}ff${B}FFFF${R}"
	echo "${B}     FFFFFF${T}fff${W}########${T}fffff${B}FFFF${R}"
	echo "${B}     FFFF${T}fffff${W}########${T}fff${B}FFFFFF${R}"
	echo "${B}     FFFF${T}ff${B}FFFFFF${W}##${B}FFFFFFFFFFFF${R}"
	echo "${B}      FFF${T}fff${B}FFFFF${W}##${B}FFFFFFFFFFF${R}"
	echo "${B}       FFF${T}ff${W}#######${B}FFFFFFFFFF${R}"
	echo "${B}        FFF${W}#######${B}FFFFFFFFFF${R}"
	echo "${B}         FFFFFFFFFFFFFFFFFF${R}"
	echo "${B}            FFFFFFFFFFFF   ${W}Success!${R}"
	echo " "
        exit
done
