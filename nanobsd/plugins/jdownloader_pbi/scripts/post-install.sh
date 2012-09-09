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
sed -i '' -e "s,www,jdown,g" ${JDOWNLOADER_HOME}/etc/rc.d/jdownloaderd

sed -i '' -e "s,-U jdown,-U root,g" ${JDOWNLOADER_HOME}/etc/rc.d/jdownloaderd

sed -i '' -e "25a\\
_dirs=\"/var/run/JDownloader /var/log/JDownloader\"" ${JDOWNLOADER_HOME}/etc/rc.d/jdownloaderd


sed -i '' -e "26a\\
start_precmd=\"mkdir -p \$_dirs; touch /var/run/JDownloader/JDownloader.pid; chown -R \$jdownloader_user \$_dirs; ldconfig -m /usr/pbi/jdownloader-amd64/lib\"" ${JDOWNLOADER_HOME}/etc/rc.d/jdownloaderd

sed -i '' -e "27a\\
RUN_AS_USER=\"jdown\"" ${JDOWNLOADER_HOME}/etc/rc.d/jdownloaderd

# Need to put/replace this in /usr/local/etc/rc.d/jdownloaderd
#command='/usr/pbi/jdownloader-amd64/sbin/jdownloader'
#sed -i '' -e "s,command=,command=env DISPLAY=:1 ," ${JDOWNLOADER_HOME}/etc/rc.d/jdownloaderd


################################
### sbin/jdownloader changes ###
################################

sed -i '' -e "s,exec java,exec ${JDOWNLOADER_HOME}/bin/java,g" ${JDOWNLOADER_HOME}/sbin/jdownloader

#sed -i '' -e "12a\\
#setenv FontPath \"/usr/local/lib/X11/fonts/\"" ${JDOWNLOADER_HOME}/sbin/jdownloader

# Need to add these lines after LOGFILE line
sed -i '' -e "5a\\
XVFB_ENABLE=`grep Xvfb /usr/pbi/jdownloader-amd64/etc/jdownloader.conf | sed -e \"s,Xvfb_Enable= ,,\"`" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "6a\\
echo \$XVFB_ENABLE" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "7a\\
XDISPLAY=`grep \"X11_Display= \" /usr/pbi/jdownloader-amd64/etc/jdownloader.conf | sed -e \"s,X11_Display= ,,\"`" ${JDOWNLOADER_HOME}/sbin/jdownloader

#echo $XDISPLAY

sed -i '' -e "8a\\
DISPLAY=\${XDISPLAY}" ${JDOWNLOADER_HOME}/sbin/jdownloader

#export DISPLAY

# Need to test PIDfile because if user quits from X11 session FreeNAS GUI doesn't know
# Test if PIDfile exists, add to sbin/jdownloader, need to see if FreeNAS GUI can be refreshed

#sed -i '' -e "4a\\
#^M" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "9a\\
if [ -f /var/run/JDownloader/JDownloader.pid ]; then" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "10a\\
\ \ \ \ if [ -z {\$id} ]; then" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "11a\\
\ \ \ \ \ \ \ \ exit" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "12a\\
\ \ \ \ fi" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "13a\\ 
\ \ \ \ id=\`cat /var/run/JDownloader/JDownloader.pid\`" ${JDOWNLOADER_HOME}/sbin/jdownloader   

sed -i '' -e "14a\\
\ \ \ \ echo \${id}" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "15a\\
\ \ \ \ if ps -p \${id} > /dev/null" ${JDOWNLOADER_HOME}/sbin/jdownloader                     

sed -i '' -e "16a\\
\ \ \ \ \ \ \ \ then" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "17a\\
\ \ \ \ \ \ \ \ echo \"Another copy of JDownloader appears to be running already."\" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "18a\\
\ \ \ \ \ \ \ \ exit" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "19a\\
\ \ \ \ else" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "20a\\
\ \ \ \ \ \ \ \ rm /var/run/JDownloader/JDownloader.pid" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "21a\\
\ \ \ \ fi" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "22a\\
fi" ${JDOWNLOADER_HOME}/sbin/jdownloader 

#sed -i '' -e "23a\\
#ldconfig -m ${JDOWNLOADER_HOME}/lib" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "24a\\
if [ -z `pgrep Xvfb` ]; then" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "25a\\
\ \ \ \ exec /usr/pbi/jdownloader-amd64/bin/Xvfb :1 -screen 0 1024x768x16 &" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "26a\\
fi" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "27a\\
if [ -z `pgrep x11vnc` ]; then" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "28a\\
\ \ \ \ exec /usr/pbi/jdownloader-amd64/bin/x11vnc -noshm -nevershared -forever -display :1 &" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "29a\\
fi" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "30a\\
if [ -z `pgrep fluxbox` ]; then" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "31a\\
\ \ \ \ exec /usr/pbi/jdownloader-amd64/bin/fluxbox -d :1 &" ${JDOWNLOADER_HOME}/sbin/jdownloader

sed -i '' -e "32a\\
fi" ${JDOWNLOADER_HOME}/sbin/jdownloader

# Creat PID in sbin/jdownloader

echo "sleep 2" >> ${JDOWNLOADER_HOME}/sbin/jdownloader
echo "pgrep -U root -f JDownloader.jar > /var/run/JDownloader/JDownloader.pid" >> ${JDOWNLOADER_HOME}/sbin/jdownloader

mkdir -p ${JDOWNLOADER_HOME}/etc/home/jdownloader/.fluxbox
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
