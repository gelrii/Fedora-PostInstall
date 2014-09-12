Fedora-PostInstall
==================

A useful script to facilitate speedy deployment of Fedora desktop and laptop environments.

You can run this script quickly with the following command:
> curl -o /tmp/fedora.sh https://github.com/asdf-git/Fedora-PostInstall/raw/master/fedora.sh && chmod +x /tmp/fedora.sh && sudo sh /tmp/fedora.sh

Paste the above command into a terminal to execute it.


#Release Notes
- $a is a counter to allow the script to move from one while loop to another
- $k is the KDE counter, $g is Gnome and $o is Other
- $B is to change the colour of the text to blue, $T teal, $W white, $R resets colour
- The order of the script is also controlled by the until loop at the end of the script
- The name of each subroutine is a description of what is happening


#Proposed/Planned Changes
- Move project to GitHub to allow one-line auto-download to work (PasteBin is breaking the script).
- Add desktop environment specific packages to be *installed* and not just removed.
  - Install 'gnome-tweak-tools' for GNOME.
  - Install 'gnome-disk-utility' for KDE (GUI frontend to gdisks - extremely useful! and does not need to pull in any other GNOME packages to work).
- Integrate a reboot after the initial system update and resume the script after rebooting (This allows the VirtualBox section to be re-added and an NVidia drivers section to be added.
- Migrate the script to the Crunchbang postinstall script style.
- Integrate support for automatically discovering what OS is running and running different scripts accordingly (a meta postinstall script).
- Integrate Google Chrome installation support for those that need Flash.
- Integrate automatic downloader for the latest Tor browser bundle. (Pipe the downloads.html page into curl and grep out the current 64-bit .tar.gz link?)


#Changelog
- v1.0.0 - Initial framework.
- v1.0.1 - Fixed issue on line 1 that could cause problems when executing. Added version numbering.
- v1.1.0 - Removed multiple uses of 'sudo' from within script. Whole script should instead be run as root. Fixed some wording. Added VirtualBox installation section.
- v1.2.0 - Added an automatic /etc/hosts file updater.
- v1.3.0 - Added Infinality installer for improved font rendering.
- v1.3.1 - Fixed Infinality instaler.
- v1.4.0 - Added assumeyes to all yum operations.
- v1.5.0 - Added colourful ASCII to start of script.
- v1.5.1 - Added reset of colour to ASCII. Placed added information on variables in release notes.
- v1.5.2 - Added colourful ASCII to end of script.
- v1.5.3 - Fixed text of Infinality section.
- v1.5.4 - Added 'unrar' to useful package installer.
- v1.5.5 - Added 'cheese' to GNOME package remover.
- v1.5.6 - Fixed /etc/hosts file installer.
- v1.6.0 - Added installer for ownCloud Desktop Sync Client.
- v1.7.0 - Added installer for PlayOnLinux.
- v1.8.0 - Removed the VirtualBox section (causes issues installing before kernel update is complete) and replaced it with a ZFS on Linux install option.
- v1.8.1 - Added 'tuned' to the useful package installer for CPU frequency scaling.
