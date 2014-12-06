Fedora-PostInstall
==================

A useful script to facilitate speedy deployment of Fedora desktop and laptop environments.

You can run this script quickly with the following command:
<pre>curl -fsSL https://raw.githubusercontent.com/asdf-git/Fedora-PostInstall/master/fedora.sh | sh</pre>

Paste the above command into a terminal to execute it. This uses curl, as wget is not available in Fedora by default.


#Release Notes
- $a is a counter to allow the script to move from one while loop to another
- $k is the KDE counter, $g is Gnome and $o is Other
- $B is to change the colour of the text to blue, $T teal, $W white, $R resets colour
- The order of the script is also controlled by the until loop at the end of the script
- The name of each subroutine is a description of what is happening


#Proposed/Planned Changes
- Add desktop environment specific packages to be *installed* and not just removed.
  - Install 'gnome-tweak-tools' for GNOME.
  - Install 'gnome-disk-utility' for KDE (GUI frontend to gdisks - extremely useful! and does not need to pull in any other GNOME packages to work).
- Integrate a reboot after the initial system update and resume the script after rebooting (This allows the VirtualBox section to be re-added and an NVidia drivers section to be added.
- Migrate the script to the Crunchbang postinstall script style.
- Integrate support for automatically discovering what OS is running and running different scripts accordingly (a meta postinstall script).
- Integrate Google Chrome installation support for those that need Flash.
- Integrate automatic downloader for the latest Tor browser bundle. (Pipe the downloads.html page into curl and grep out the current 64-bit .tar.gz link?)
