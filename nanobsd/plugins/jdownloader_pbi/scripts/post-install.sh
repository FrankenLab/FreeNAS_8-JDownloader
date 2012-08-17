#!/bin/sh

echo libz.so.4 libz.so.5 > /etc/libmap.conf
echo libz.so.4 libz.so.5 > /usr/pbi/jdownloader-`uname -m`/etc/libmap.conf


mkdir -p /usr/pbi/jdownloader-`uname -m`/etc/jdownloader/home
pw groupadd www
pw useradd www -g www -G wheel -s /usr/local/bin/bash -d /usr/pbi/jdownloader-`uname -m`/etc/jdownloader/home -w none

chown www:www /usr/pbi/jdownloader-`uname -m`/MEDIA
chmod 775 /usr/pbi/jdownloader-`uname -m`/MEDIA

# Copy patched RC file over automatically generated one
mkdir -p /usr/pbi/jdownloader-`uname -m`/etc/rc.d/
chmod 755 /usr/pbi/jdownloader-`uname -m`/jdownloader.RC
cp /usr/pbi/jdownloader-`uname -m`/jdownloader.RC /usr/pbi/jdownloader-`uname -m`/etc/rc.d/jdownloader


# Add JAIL_IP into /usr/pbi/sbin/jdownloaderd
# Probably should add JAIL_IP line into jdownloaderd

JAIL_IP=`ifconfig  | grep -E 'inet.[0-9]' | grep -v '127.0.0.1' | awk '{ print \$2}'`

echo $JAIL_IP"	"`hostname` >> /etc/hosts

echo 'jdownloader_flags=""' > /usr/pbi/jdownloader-`uname -m`/etc/rc.conf
echo 'jdownloader_flags=""' > /etc/rc.conf

/usr/pbi/jdownloader-`uname -m`/bin/python /usr/pbi/jdownloader-`uname -m`/jdownloaderUI/manage.py syncdb --migrate --noinput
