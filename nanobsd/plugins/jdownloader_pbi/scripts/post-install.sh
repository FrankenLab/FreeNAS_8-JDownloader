#!/bin/sh

JDOWNLOADER_HOME=/usr/pbi/jdownloader-`uname -m`

echo libz.so.4 libz.so.5 > /etc/libmap.conf
echo libz.so.4 libz.so.5 > /usr/pbi/jdownloader-`uname -m`/etc/libmap.conf

#cp -a /usr/local/sbin/jdownloader /usr/pbi/jdownloader-`uname -m`/sbin/jdownloader
#chown www:www /usr/pbi/jdownloader-`uname -m`/sbin/jdownloader
#chown -R www:www /usr/pbi/jdownloader-`uname -m`/

sed -i '' -e "s,exec java,exec ${JDOWNLOADER_HOME}/bin/java,g" ${JDOWNLOADER_HOME}/sbin/jdownloader

mkdir -p /usr/local/lib/X11/fonts
(cd /usr/local/lib/X11/fonts ; tar xf ${JDOWNLOADER_HOME}/fonts.tar)
rm ${JDOWNLOADER_HOME}/fonts.tar
#tar xf fonts.tar /usr/local/lib/fonts/

# setenv FontPath "/usr/local/lib/X11/fonts/" (Add to sbin/jdownloader with sed)
sed -i '' -e "12a\\
setenv FontPath \"/usr/local/lib/X11/fonts/\"" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "13a\\
ldconfig -m /usr/pbi/${JDOWNLOADER_HOME}/lib" ${JDOWNLOADER_HOME}/sbin/jdownloader

# Need to put/replace this in /usr/local/etc/rc.d/jdownloaderd
# command=env DISPLAY=192.168.2.1:0.0 FontPath="/usr/local/lib/X11/fonts/" /usr/pbi/jdownloader-amd64/sbin/jdownloader

mkdir -p /usr/pbi/jdownloader-`uname -m`/etc/jdownloader/home
pw groupadd www
pw useradd www -g www -G wheel -s /bin/sh -d /usr/pbi/jdownloader-`uname -m`/etc/jdownloader/home -w none

mkdir -p /usr/pbi/jdownloader-`uname -m`/downloads
chown www:www /usr/pbi/jdownloader-`uname -m`/downloads
chmod 775 /usr/pbi/jdownloader-`uname -m`/downloads

mkdir -p /var/run/JDownloader /var/log/JDownloader
touch /var/run/JDownloader/JDownloader.pid /var/log/JDownloader/JDownloader.log
chown -R www:www /var/run/JDownloader /var/log/JDownloader

ln -sf /usr/pbi/${JDOWNLOADER_HOME}/bin/unrar /usr/local/bin/unrar

ldconfig -m /usr/pbi/${JDOWNLOADER_HOME}/lib

#ln -sf /usr/pbi/${JDOWNLOADER_HOME}/openjdk6/jre/lib/amd64/xawt/libmawt.so /usr/local/lib/
#find /usr/pbi/${JDOWNLOADER_HOME}/lib -name "libXrender.*" -exec ln -sf {} /usr/local/lib/ \;
#find /usr/pbi/${JDOWNLOADER_HOME}/lib -name "libmawt.*" -exec ln -sf {} /usr/local/lib/ \;
#find /usr/pbi/${JDOWNLOADER_HOME}/lib -name "libXtst.*" -exec ln -sf {} /usr/local/lib/ \;
#find /usr/pbi/${JDOWNLOADER_HOME}/lib -name "libXi.*" -exec ln -sf {} /usr/local/lib/ \;

# Remove the port tree
rm -rf /usr/pbi/jdownloader-`uname -m`/usr
#/usr/pbi/jdownloader-amd64/usr/ports/net/jdownloader

echo $JAIL_IP"	"`hostname` >> /etc/hosts

echo 'jdownloader_flags=""' > /usr/pbi/jdownloader-`uname -m`/etc/rc.conf
echo 'jdownloader_flags=""' > /etc/rc.conf

/usr/pbi/jdownloader-`uname -m`/bin/python /usr/pbi/jdownloader-`uname -m`/jdownloaderUI/manage.py syncdb --migrate --noinput
