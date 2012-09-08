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

sed -i '' -e "s,exec java,exec ${JDOWNLOADER_HOME}/bin/java,g" ${JDOWNLOADER_HOME}/sbin/jdownloader

# setenv FontPath "/usr/local/lib/X11/fonts/" (Add to sbin/jdownloader with sed)
#sed -i '' -e "12a\\
#setenv FontPath \"/usr/local/lib/X11/fonts/\"" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "13a\\
ldconfig -m ${JDOWNLOADER_HOME}/lib" ${JDOWNLOADER_HOME}/sbin/jdownloader

# Need to put/replace this in /usr/local/etc/rc.d/jdownloaderd
sed -i '' -e "s,command=,command=env DISPLAY=:1 ," ${JDOWNLOADER_HOME}/etc/rc.d/jdownloaderd

# Changed script user from www to jdown
sed -i '' -e "s,www,jdown,g" ${JDOWNLOADER_HOME}/etc/rc.d/jdownloaderd

# Need to test PIDfile because if user quits from X11 session FreeNAS GUI doesn't know
# Test if PIDfile exists, add to sbin/jdownloader, need to see if FreeNAS GUI can be refreshed

#sed -i '' -e "3a\\
#^M" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "5a\\
if [ -f /var/run/JDownloader/JDownloader.pid ]; then" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "6a\\
\ \ \ \ if [ -z \{$id} ]; then" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "7a\\
\ \ \ \ \ \ \ \ exit" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "8a\\
\ \ \ \ fi" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "9a\\ 
\ \ \ \ id=\`cat /var/run/JDownloader/JDownloader.pid\`" ${JDOWNLOADER_HOME}/sbin/jdownloader   

sed -i '' -e "10a\\
\ \ \ \ echo \${id}" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "11a\\
\ \ \ \ if ps -p \${id} > /dev/null" ${JDOWNLOADER_HOME}/sbin/jdownloader                     

sed -i '' -e "12a\\
\ \ \ \ \ \ \ \ then" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "13a\\
\ \ \ \ \ \ \ \ echo \"Another copy of JDownloader appears to be running already."\" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "14a\\
\ \ \ \ \ \ \ \ exit" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "15a\\
\ \ \ \ else" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "16a\\
\ \ \ \ \ \ \ \ rm /var/run/JDownloader/JDownloader.pid" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "17a\\
\ \ \ \ fi" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "18a\\
fi" ${JDOWNLOADER_HOME}/sbin/jdownloader 

#if [ -f /var/run/JDownloader/JDownloader.pid ]; then
#    if [ !$id ]; then
#        (exit)
#    fi    
#    echo ${id}    
#    if ps -p ${id} > /dev/null    
#        then    
#            echo "Another copy of JDownloader appears to be running already."    
#            (exit)    
#        else
#            rm /var/run/JDownloader/JDownloader.pid
#    fi
#fi

#if [ -z `pgrep Xvfb` ]; then
#    exec /usr/pbi/jdownloader-amd64/bin/Xvfb :1 -screen 0 1024x768x16 &
#    echo "Xvfb not running?"
#fi
#if [ -z `pgrep x11vnc` ]; then
#    echo "x11vnc not running?"
#    exec /usr/pbi/jdownloader-amd64/bin/x11vnc -noshm -nevershared -forever -display :1 &
#fi
#if [ -z `pgrep fluxbox` ]; then
#    exec /usr/pbi/jdownloader-amd64/bin/fluxbox -d :1 &
#    echo "fluxbox not running?"
#fi

# Creat PID in sbin/jdownloader

echo "sleep 2" >> ${JDOWNLOADER_HOME}/sbin/jdownloader
echo "pgrep -U jdown -f JDownloader.jar > /var/run/JDownloader/JDownloader.pid" >> ${JDOWNLOADER_HOME}/sbin/jdownloader


mkdir -p ${JDOWNLOADER_HOME}/etc/home/jdownloader
pw groupadd jdown
pw useradd jdown -g jdown -G wheel -s /bin/sh -d ${JDOWNLOADER_HOME}/etc/home/jdownloader-w none
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

echo 'jdownloader_flags=""' > ${JDOWNLOADER_HOME}/etc/rc.conf
echo 'jdownloader_flags=""' > /etc/rc.conf

${JDOWNLOADER_HOME}/bin/python ${JDOWNLOADER_HOME}/jdownloaderUI/manage.py syncdb --migrate --noinput
