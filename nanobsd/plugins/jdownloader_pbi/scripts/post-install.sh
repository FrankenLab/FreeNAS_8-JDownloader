#!/bin/sh

echo libz.so.4 libz.so.5 > /etc/libmap.conf
echo libz.so.4 libz.so.5 > /usr/pbi/jdownloader-`uname -m`/etc/libmap.conf

#cp -a /usr/local/sbin/jdownloader /usr/pbi/jdownloader-`uname -m`/sbin/jdownloader
#chown www:www /usr/pbi/jdownloader-`uname -m`/sbin/jdownloader
chown -R www:www /usr/pbi/jdownloader-`uname -m`/


mkdir -p /usr/pbi/jdownloader-`uname -m`/etc/jdownloader/home
pw groupadd www
pw useradd www -g www -G wheel -s /usr/local/bin/bash -d /usr/pbi/jdownloader-`uname -m`/etc/jdownloader/home -w none

mkdir -p www:www /usr/pbi/jdownloader-`uname -m`/downloads
chown www:www /usr/pbi/jdownloader-`uname -m`/downloads
chmod 775 /usr/pbi/jdownloader-`uname -m`/downloads

# Remove the port tree
#rm -rf /usr/pbi/jdownloader-`uname -m`/usr
#/usr/pbi/jdownloader-amd64/usr/ports/net/jdownloader

echo $JAIL_IP"	"`hostname` >> /etc/hosts

echo 'jdownloader_flags=""' > /usr/pbi/jdownloader-`uname -m`/etc/rc.conf
echo 'jdownloader_flags=""' > /etc/rc.conf

/usr/pbi/jdownloader-`uname -m`/bin/python /usr/pbi/jdownloader-`uname -m`/jdownloaderUI/manage.py syncdb --migrate --noinput
