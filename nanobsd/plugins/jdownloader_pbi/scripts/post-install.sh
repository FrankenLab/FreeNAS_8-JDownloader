#!/bin/sh

JDOWNLOADER_HOME=/usr/pbi/jdownloader-`uname -m`

echo libz.so.4 libz.so.5 > /etc/libmap.conf
echo libz.so.4 libz.so.5 > ${JDOWNLOADER_HOME}/etc/libmap.conf

##########################
# INSTALL FONTS FOR X11
##########################

mkdir -p /usr/local/lib/X11/fonts
(cd /usr/local/lib/X11/fonts ; cp -a ${JDOWNLOADER_HOME}/fonts/* .)
rm -rf ${JDOWNLOADER_HOME}/fonts

#(cd /usr/local/lib/X11/fonts ; tar xf ${JDOWNLOADER_HOME}/fonts.tar)
#rm ${JDOWNLOADER_HOME}/fonts.tar

##########################
# SED Stuff
##########################

#################################
### rc.d/jdownloaderd changes ###
#################################

# Changed script user from www to jdown
#sed -i '' -e "s,www,jdown,g" ${JDOWNLOADER_HOME}/etc/rc.d/jdownloaderd

#sed -i '' -e "s,-U jdown,-U root,g" ${JDOWNLOADER_HOME}/etc/rc.d/jdownloaderd

#sed -i '' -e "25a\\
#_dirs=\"/var/run/JDownloader /var/log/JDownloader\"" ${JDOWNLOADER_HOME}/etc/rc.d/jdownloaderd


#sed -i '' -e "26a\\
#start_precmd=\"mkdir -p \$_dirs; touch /var/run/JDownloader/JDownloader.pid; chown -R \$jdownloader_user \$_dirs; ldconfig -m /usr/pbi/jdownloader-amd64/lib\"" ${JDOWNLOADER_HOME}/etc/rc.d/jdownloaderd

#sed -i '' -e "27a\\
#RUN_AS_USER=\"jdown\"" ${JDOWNLOADER_HOME}/etc/rc.d/jdownloaderd

# Need to put/replace this in /usr/local/etc/rc.d/jdownloaderd
#command='/usr/pbi/jdownloader-amd64/sbin/jdownloader'
#sed -i '' -e "s,command=,command=env DISPLAY=:1 ," ${JDOWNLOADER_HOME}/etc/rc.d/jdownloaderd

# Copy template wrapper script over existing script
#cat ${JDOWNLOADER_HOME}/sbin_jdownloader ${JDOWNLOADER_HOME}/sbin/jdownloader
cp -a ${JDOWNLOADER_HOME}/sbin_jdownloader ${JDOWNLOADER_HOME}/sbin/jdownloader
chmod 755 ${JDOWNLOADER_HOME}/sbin/jdownloader

# Copy template RC script over existing script
cp -a ${JDOWNLOADER_HOME}/rc_jdownloaderd ${JDOWNLOADER_HOME}/etc/rc.d/jdownloaderd
cp -a ${JDOWNLOADER_HOME}/rc_jdownloaderd /usr/local/etc/rc.d/jdownloaderd
chmod 755 /usr/local/etc/rc.d/jdownloaderd

mkdir -p ${JDOWNLOADER_HOME}/etc/home/jdownloader/.fluxbox
pw groupadd jdown
pw useradd jdown -g jdown -G wheel -s /bin/sh -d ${JDOWNLOADER_HOME}/etc/home/jdownloader -w none
chown -R jdown:jdown ${JDOWNLOADER_HOME}/etc/home/jdownloader

mkdir -p ${JDOWNLOADER_HOME}/downloads
chown jdown:jdown ${JDOWNLOADER_HOME}/downloads
chmod 775 ${JDOWNLOADER_HOME}/downloads

mkdir -p /var/run/JDownloader /var/log/JDownloader
touch /var/run/JDownloader/JDownloader.pid /var/log/JDownloader/JDownloader.log
chown -R jdown:jdown /var/run/JDownloader /var/log/JDownloader

##########################
# LINKS
##########################

ln -sf ${JDOWNLOADER_HOME}/bin/unrar /usr/local/bin/unrar
ln -sf ${JDOWNLOADER_HOME}/etc/rc.d/jdownloaderd /usr/local/etc/rc.d/jdownloaderd

ldconfig -m ${JDOWNLOADER_HOME}/lib
ldconfig -m /usr/pbi/jdownloader-`uname -m`/openjdk6/jre/lib/`uname -m`

#ln -sf /usr/pbi/${JDOWNLOADER_HOME}/openjdk6/jre/lib/amd64/xawt/libmawt.so /usr/local/lib/
#find /usr/pbi/${JDOWNLOADER_HOME}/lib -name "libXrender.*" -exec ln -sf {} /usr/local/lib/ \;
#find /usr/pbi/${JDOWNLOADER_HOME}/lib -name "libmawt.*" -exec ln -sf {} /usr/local/lib/ \;
#find /usr/pbi/${JDOWNLOADER_HOME}/lib -name "libXtst.*" -exec ln -sf {} /usr/local/lib/ \;
#find /usr/pbi/${JDOWNLOADER_HOME}/lib -name "libXi.*" -exec ln -sf {} /usr/local/lib/ \;

##########################
# CLEANUP
##########################

# Remove the port tree
rm -rf ${JDOWNLOADER_HOME}/usr
#/usr/pbi/jdownloader-amd64/usr/ports/net/jdownloader


#echo $JAIL_IP"	"`hostname` >> /etc/hosts

echo 'jdownloader_flags=""' >> ${JDOWNLOADER_HOME}/etc/rc.conf
echo 'jdownloader_flags=""' >> /etc/rc.conf

${JDOWNLOADER_HOME}/bin/python ${JDOWNLOADER_HOME}/jdownloaderUI/manage.py syncdb --migrate --noinput
