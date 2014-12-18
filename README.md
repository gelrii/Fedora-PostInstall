Fedora-PostInstall
==================

A useful script to facilitate speedy deployment of Fedora desktop and laptop environments.

You can run this script quickly with the following command:
<pre>+<pre>curl -fsSL https://raw.githubusercontent.com/asdf-git/Fedora-PostInstall/master/Fedora.sh -o /tmp/Fedora.sh && sudo sh /tmp/Fedora.sh</pre></pre>

Paste the above command into a terminal to execute it. This uses curl, as wget is not available in Fedora by default.


#Proposed/Planned Changes
- Add desktop environment specific packages to be *installed* and not just removed.
  - Install 'gnome-tweak-tools' for GNOME. Also ask whether to install Dolphin in GNOME.
  - Install 'gnome-disk-utility' for KDE (GUI frontend to gdisks - extremely useful! and does not need to pull in any other GNOME packages to work).

- Integrate a reboot after the initial system update and resume the script after rebooting (This allows the VirtualBox section to be re-added and an NVidia drivers section to be added.
  - Accomplish by writing out to a file what sections have been executed before and skipping over them next time the script is run?

- Migrate the script to the Crunchbang postinstall script style.

- Integrate Google Chrome installation support for those that need Flash.

- Integrate automatic downloader for the latest Tor browser bundle.
  - (Pipe the TorProject downloads.html page into curl and grep out the current 64-bit .tar.gz link then unzip it to ~/ maybe?)
