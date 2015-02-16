Fedora-PostInstall
==================

A useful script to facilitate speedy deployment of Fedora desktop and laptop environments.

This script is particularly tailored for my own usage (particularly the parts that remove packages I don't find useful and install packages I do), but anyone is free to use/modify/fork it if you feel it would be useful for your purposes.

You can run this script quickly with the following command:
<pre>curl -fsSL https://raw.githubusercontent.com/asdf-git/Fedora-PostInstall/master/Fedora.sh -o /tmp/Fedora.sh && sudo sh /tmp/Fedora.sh</pre>

Paste the above command into a terminal to execute it. This uses curl, as wget is not available in Fedora by default.


#Proposed/Planned Changes
- Add desktop *environment specific* packages to be *installed* and not just removed.
  - Install 'gnome-tweak-tools', but only when GNOME is the active DE. Also ask whether to install Dolphin and Konsole in GNOME.

- Integrate a reboot after the initial system update and resume the script after rebooting?
  - (Would allow the VirtualBox section to be re-added and an NVidia drivers section to be added.)
  - Accomplish by writing out to a file what sections have been executed before and skipping over them next time the script is run?

- Integrate automatic downloader for the latest Tor browser bundle.
  - (Pipe the TorProject downloads.html page into curl and grep out the current 64-bit .tar.gz link then unzip it to ~/ maybe?)
