Fedora-PostInstall
==================

A useful script to facilitate speedy deployment of Fedora desktop and laptop environments.

This script is a fork of another Fedora postinstall script found at https://github.com/ajhaydock/FedPo particularly tailored for my own usage (particularly the parts that remove packages I don't find useful and install packages I do), but anyone is free to use/modify/fork it if you feel it would be useful for your purposes.

You can run this script quickly with the following command:
<pre>curl -fsSL https://raw.githubusercontent.com/gelrii/Fedora-Postinstall/master/Fedora.sh -o /tmp/Fedora.sh && sh /tmp/Fedora.sh</pre>

Paste the above command into a terminal to execute it. This uses curl, as wget is not available in Fedora by default.
