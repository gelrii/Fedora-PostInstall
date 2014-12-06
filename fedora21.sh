#!/bin/bash

# Fedora 21 PostInstall Script
version="2.0 (20141206)"
fvsupp="21" #(Fedora release version this script targets)

# Check if we're running as root
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
# Fedora Version Check

a=1
k=0
g=0
o=0
B=$(tput setaf 4)
T=$(tput setaf 6)
W=$(tput setaf 7)
R=$(tput sgr0)

clear

echo "           /:-------------:\          #############################################"
echo "        :-------------------::        # Welcome to the Fedora PostInstall Script! #"
echo "      :-----------/shhOHbmp---:\      #############################################"
echo "    /-----------omMMMNNNMMD  ---:     "
echo "   :-----------sMMMMNMNMP     ---:    You are running script version $version."
echo "  :-----------:MMMdP-----      ---    "
echo " ,------------:MMMd------      ---:   You will be asked a series of questions to"
echo " :------------:MMMd-----      .---:   help us configure your system."
echo " :----    oNMMMMMMMMMNho     .----:   "
echo " :--      +shhhMMMmhhy++   .------    Please answer with Y or N,"
echo " :-      -----:MMMd--------------:    or enter Q at any prompt to quit the script."
echo " :-     ------/MMMd-------------;     "
echo " :-    ..----/hMMMy------------:      This script is optimised and tested on"
echo " :-- :dMNdhhdNMMNo------------;       Fedora $fvsupp."
echo " :---:sdNMMMMNds:------------:        "
echo " :------:://:-------------::          Earlier or later Fedora releases may be"
echo " :---------------------://            compatible, but have not been tested."

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
                        echo "Continuing..."
                        ;;
                        q) a=0
                        echo "Exiting..."
                        exit
                        ;;
        esac
done
}

Desktop_Environment () {
        while [ $a = 2 ]; do
                echo " "
                echo "Select Your Desktop Environment"
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
                        echo "Exiting..."
                        exit
                        ;;
        esac
done
}

Remove_KDE_Packages () {
        while [ $k = 1 ]; do
                echo "KDE Selected"
                echo "Remove (Mostly) Useless KDE Packages?"
                echo "     Y / N"
                echo " "
                read opt
                case $opt in
                        y) k=0
                        echo "Removing..."
                        yum remove gwenview dragon amarok
                        echo "Removed Useless KDE Packages."
                        ;;
                        n) k=0
                        echo "Keeping All Packages."
                        ;;
                        q) k=0
                        a=0
                        echo "Exiting..."
                        exit
                        ;;
                esac
done
}

Remove_Gnome_Packages () {
        while [ $g = 1 ]; do
                echo "GNOME Selected"
                echo "Remove (Mostly) Useless GNOME Packages?"
                echo "     Y / N"
                echo " "
                read opt
                case $opt in
                        y) g=0
                        echo "Removing..."
                        yum remove rhythmbox empathy totem evolution shotwell cheese
                        echo "Removed Useless GNOME Packages."
                        ;;
                        n) g=0
                        echo "Keeping All Packages."
                        ;;
                        q) g=0
                        a=0
                        echo "Exiting..."
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
                        echo "Continuing..."
                        ;;
                        q) a=0
                        echo "Exiting..."
                        exit
                        ;;
        esac
done
}

Install_Packages () {
        while [ $a = 5 ]; do
                echo " "
                echo "Install Useful Package Selection?"
                echo "(Some Packages Subject to Non-Free Licenses)"
                echo "     Y / N"
                echo " "
                read opt
                case $opt in
                        y) a=6
                        echo "Installing Packages..."
                        yum install clementine transgui htop nano tuned xchat vlc lm_sensors iotop iftop gcc kernel-headers kernel-devel gnome-disk-utility firefox thunderbird keepass remmina-plugins-rdp ffmpeg mkvtoolnix youtube-dl eog recordmydesktop gpg gimp wget ntp unrar
                        echo "Installed Packages."
                        ;;
                        n) a=6
                        echo "Continuing..."
                        ;;
                        q) a=0
                        echo "Exiting..."
                        exit
                        ;;
        esac
done
}

Enable_SSH () {
        while [ $a = 6 ]; do
                echo " "
                echo "Enable and Start SSH Server?"
                echo "     Y / N"
                echo " "
                read opt
                case $opt in
                        y) a=7
                        echo "Enabling SSH Server..."
                        systemctl enable sshd.service && systemctl start sshd.service && systemctl status sshd.service
                        echo "Enabled SSH Server"
                        ;;
                        n) a=7
                        echo "Continuing..."
                        ;;
                        q) a=0
                        echo "Exiting..."
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
                        echo "Continuing..."
                        ;;
                        q) a=0
                        echo "Exiting..."
                        exit
                        ;;
        esac
done
}

Hosts_Block () {
        while [ $a = 8 ]; do
                echo " "
                echo "Install Custom Hosts File to Block Ads/Malicious IPs?"
                echo "     Y / N"
                echo " "
                read opt
                case $opt in
                        y) a=9
                        echo "Installing Custom Hosts File to /etc/hosts..."
                        cd /etc && rm /etc/hosts && sudo curl -C - -O http://someonewhocares.org/hosts/hosts
                        echo "Installed Custom Hosts File."
                        ;;
                        n) a=9
                        echo "Continuing..."
                        ;;
                        q) a=0
                        echo "Exiting..."
                        exit
                        ;;
        esac
done
}

Fix_Fonts () {
        while [ $a = 9 ]; do
                echo " "
                echo "Install Infinality to Improve Font Render Quality?"
                echo "     Y / N"
                echo " "
                read opt
                case $opt in
                        y) a=10
                        echo "Installing Infinality..."
# Note to script maintainers: The first command in the below line will need updating when the repo is updated.
# Check this page every so often to see if there have been updates: http://www.infinality.net/blog/infinality-repository/
                        rpm -Uvh http://www.infinality.net/fedora/linux/infinality-repo-1.0-1.noarch.rpm && yum install freetype-infinality fontconfig-infinality
                        echo "Installed Infinality."
                        echo "Changes to font rendering may not be visible until a reboot."
                        ;;
                        n) a=10
                        echo "Continuing..."
                        ;;
                        q) a=0
                        echo "Exiting..."
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
                        echo "Continuing..."
                        ;;
                        q) a=0
                        echo "Exiting..."
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
                        wget -O /tmp/playonlinux.rpm http://rpm.playonlinux.com/playonlinux-yum-4-1.noarch.rpm && yum -y install /tmp/playonlinux.rpm && yum install playonlinux
                        echo "Installed PlayOnLinux."
                        ;;
                        n) a=12
                        echo "Continuing..."
                        ;;
                        q) a=0
                        echo "Exiting..."
                        exit
                        ;;
        esac
done
}

until [ $a = 0 ]; do
        Enable_RPMFusion
        Desktop_Environment
        System_Update
        Install_Packages
        Enable_SSH
        Install_ZoL
        Hosts_Block
        Fix_Fonts
        Install_ownCloud
        Install_POL
curl -o /tmp/screenfetch https://raw.githubusercontent.com/KittyKatt/screenFetch/master/screenfetch-dev && chmod +x /tmp/screenfetch && clear && echo "Success! Enjoy Your System" && echo "" && /tmp/screenfetch
exit
done
