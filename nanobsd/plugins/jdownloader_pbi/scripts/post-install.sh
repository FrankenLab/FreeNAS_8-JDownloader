#!/bin/sh

JDOWNLOADER_HOME=/usr/pbi/jdownloader-`uname -m`

echo libz.so.4 libz.so.5 > /etc/libmap.conf
echo libz.so.4 libz.so.5 > /usr/pbi/jdownloader-`uname -m`/etc/libmap.conf

#cp -a /usr/local/sbin/jdownloader /usr/pbi/jdownloader-`uname -m`/sbin/jdownloader
#chown www:www /usr/pbi/jdownloader-`uname -m`/sbin/jdownloader
#chown -R www:www /usr/pbi/jdownloader-`uname -m`/

sed -i '' -e "s,exec java,exec ${JDOWNLOADER_HOME}/bin/java,g" ${JDOWNLOADER_HOME}/sbin/jdownloader

mkdir -p /usr/pbi/jdownloader-`uname -m`/etc/jdownloader/home
pw groupadd www
pw useradd www -g www -G wheel -s /bin/sh -d /usr/pbi/jdownloader-`uname -m`/etc/jdownloader/home -w none

mkdir -p www:www /usr/pbi/jdownloader-`uname -m`/downloads
chown www:www /usr/pbi/jdownloader-`uname -m`/downloads
chmod 775 /usr/pbi/jdownloader-`uname -m`/downloads

ln -sf /usr/pbi/${JDOWNLOADER_HOME}/openjdk7/jre/lib/amd64/xawt/libmawt.so /usr/local/lib/
find /usr/pbi/${JDOWNLOADER_HOME}/lib -name "libXrender.*" -exec ln -sf {} /usr/local/lib/ \;
find /usr/pbi/${JDOWNLOADER_HOME}/lib -name "libmawt.*" -exec ln -sf {} /usr/local/lib/ \;
find /usr/pbi/${JDOWNLOADER_HOME}/lib -name "libXtst.*" -exec ln -sf {} /usr/local/lib/ \;
find /usr/pbi/${JDOWNLOADER_HOME}/lib -name "libXi.*" -exec ln -sf {} /usr/local/lib/ \;

# Remove the port tree
#rm -rf /usr/pbi/jdownloader-`uname -m`/usr
#/usr/pbi/jdownloader-amd64/usr/ports/net/jdownloader

echo $JAIL_IP"	"`hostname` >> /etc/hosts

echo 'jdownloader_flags=""' > /usr/pbi/jdownloader-`uname -m`/etc/rc.conf
echo 'jdownloader_flags=""' > /etc/rc.conf

/usr/pbi/jdownloader-`uname -m`/bin/python /usr/pbi/jdownloader-`uname -m`/jdownloaderUI/manage.py syncdb --migrate --noinput
