FreeNAS_8-JDownloader
=====================

JDownloader Plugin for FreeNAS 8

You need to set/EXPORT your X11 DISPLAY variable before running JDownloader.
In the jdownloader script located in /usr/local/sbin, there is an example line
commented out.

If you prefer to run JDownloader "Headless", you can enable the option in the
FreeNAS 8 GUI for this plugin, then you can use VNC to attach and control
a virtual X Display, Xvfb and view JDownloader. The disadvantage to this
method is that JDownloader may not be able to detect selected links from
the client and also may possibly crash if a catcha prompt pops up. The 
advantage is you can disconnect and let it run in the background.

You need to run x11vnc from the command line ONCE to have it prompt you
for a password that you will use when connecting remotely with VNC.

If you run into difficulties building with this option, make sure you
update libdrm portupgrade -f libdrm
possibly need to do portmaster -r pcre-8.31
cd /usr/local/ports/textproc/p5-XML-Parser and make reinstall

JDownloader also has several different web interface plugins you can enable
from the GUI which allow you to control and add downloads.

If you choose to uninstall JDownloader, there may be some config and temporary
files in /usr/local/share/java/JDownloader that need to be removed manually.