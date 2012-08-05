#!/bin/sh
set -e

if test -z "$JDOWNLOADER_DIRECTORY"; then
	# You can override this default by setting JDOWNLOADER_DIRECTORY
	JDOWNLOADER_DIRECTORY=~/.jdownloader
fi

LOG_FILE=${JDOWNLOADER_DIRECTORY}/jdownloader.log
JAVA_OPTIONS="-Xmx512m"
NUMBER_OF_UPDATE_MIRRORS=3

download_updater() {
	RANDOM_NUMBER=$(dd if=/dev/urandom count=1 2> /dev/null | cksum | cut -f1 -d" ")
	MIRROR_NUMBER=$(expr ${RANDOM_NUMBER} % ${NUMBER_OF_UPDATE_MIRRORS} || true)
	MIRROR="http://update${MIRROR_NUMBER}.jdownloader.org/"

	rm -f jdupdate.jar
	echo "$0: Download jdupdate.jar from ${MIRROR}." >> ${LOG_FILE}
	wget --append-output=${LOG_FILE} ${MIRROR}/jdupdate.jar || zenity --error --text "The JDownloader updater could not be downloaded. Check your Internet connection and try again.\n\nThe error log can be found in\n${LOG_FILE}."

	rm -f jdupdate.jar.md5
	echo "$0: Download jdupdate.jar.md5 from ${MIRROR}." >> ${LOG_FILE}
	wget --append-output=${LOG_FILE} ${MIRROR}/jdupdate.jar.md5 || zenity --error --text "The JDownloader updater MD5 sum file could not be downloaded. Check your Internet connection and try again.\n\nThe error log can be found in\n${LOG_FILE}."

	ACTUAL_MD5SUM=$(md5sum jdupdate.jar | cut -f1 -d" ")
	TARGET_MD5SUM=$(cat jdupdate.jar.md5)
	if test "$ACTUAL_MD5SUM" != "$TARGET_MD5SUM"; then
		zenity --warning --text "The MD5 sum of the JDownloader updater mismatches. It is ${ACTUAL_MD5SUM}, but it should be ${TARGET_MD5SUM}. Either there was a download error, or one of the files (downloader or md5 sum file) is not up-to-date.\n\nThe log file can be found in\n${LOG_FILE}."
	fi
}

# determine command line parameters
while getopts 'u' OPTION 2> /dev/null; do
	case $OPTION in
	u)	UPDATE=1
		;;
	esac
done

# create JDownloader directory
mkdir -p "${JDOWNLOADER_DIRECTORY}"
cd "${JDOWNLOADER_DIRECTORY}"

# clear log
> ${LOG_FILE}

# download updater, if it is missing (e.g. first run)
if test ! -f jdupdate.jar; then
	echo "$0: No installer/updater found in ${JDOWNLOADER_DIRECTORY}." >> ${LOG_FILE}
	download_updater
fi

# start update if requested
if test "$UPDATE" = "1"; then
	echo "$0: Starting updater by your request." >> ${LOG_FILE}
	exec java ${JAVA_OPTIONS} -jar jdupdate.jar
elif test -f JDownloader.jar; then
	echo "$0: Starting JDownloader." >> ${LOG_FILE}
	exec java ${JAVA_OPTIONS} -jar JDownloader.jar $*
else
	# run updater, if JDownloader.jar does not exist
	echo "$0: No valid JDownloader.jar exist. Starting updater." >> ${LOG_FILE}
	exec java ${JAVA_OPTIONS} -jar jdupdate.jar
fi
root@vubuntu:/home/vadmin# clear

root@vubuntu:/home/vadmin# cat /usr/bin/jdownloader
#!/bin/sh
set -e

if test -z "$JDOWNLOADER_DIRECTORY"; then
	# You can override this default by setting JDOWNLOADER_DIRECTORY
	JDOWNLOADER_DIRECTORY=~/.jdownloader
fi

LOG_FILE=${JDOWNLOADER_DIRECTORY}/jdownloader.log
JAVA_OPTIONS="-Xmx512m"
NUMBER_OF_UPDATE_MIRRORS=3

download_updater() {
	RANDOM_NUMBER=$(dd if=/dev/urandom count=1 2> /dev/null | cksum | cut -f1 -d" ")
	MIRROR_NUMBER=$(expr ${RANDOM_NUMBER} % ${NUMBER_OF_UPDATE_MIRRORS} || true)
	MIRROR="http://update${MIRROR_NUMBER}.jdownloader.org/"

	rm -f jdupdate.jar
	echo "$0: Download jdupdate.jar from ${MIRROR}." >> ${LOG_FILE}
	wget --append-output=${LOG_FILE} ${MIRROR}/jdupdate.jar || zenity --error --text "The JDownloader updater could not be downloaded. Check your Internet connection and try again.\n\nThe error log can be found in\n${LOG_FILE}."

	rm -f jdupdate.jar.md5
	echo "$0: Download jdupdate.jar.md5 from ${MIRROR}." >> ${LOG_FILE}
	wget --append-output=${LOG_FILE} ${MIRROR}/jdupdate.jar.md5 || zenity --error --text "The JDownloader updater MD5 sum file could not be downloaded. Check your Internet connection and try again.\n\nThe error log can be found in\n${LOG_FILE}."

	ACTUAL_MD5SUM=$(md5sum jdupdate.jar | cut -f1 -d" ")
	TARGET_MD5SUM=$(cat jdupdate.jar.md5)
	if test "$ACTUAL_MD5SUM" != "$TARGET_MD5SUM"; then
		zenity --warning --text "The MD5 sum of the JDownloader updater mismatches. It is ${ACTUAL_MD5SUM}, but it should be ${TARGET_MD5SUM}. Either there was a download error, or one of the files (downloader or md5 sum file) is not up-to-date.\n\nThe log file can be found in\n${LOG_FILE}."
	fi
}

# determine command line parameters
while getopts 'u' OPTION 2> /dev/null; do
	case $OPTION in
	u)	UPDATE=1
		;;
	esac
done

# create JDownloader directory
mkdir -p "${JDOWNLOADER_DIRECTORY}"
cd "${JDOWNLOADER_DIRECTORY}"

# clear log
> ${LOG_FILE}

# download updater, if it is missing (e.g. first run)
if test ! -f jdupdate.jar; then
	echo "$0: No installer/updater found in ${JDOWNLOADER_DIRECTORY}." >> ${LOG_FILE}
	download_updater
fi

# start update if requested
if test "$UPDATE" = "1"; then
	echo "$0: Starting updater by your request." >> ${LOG_FILE}
	exec java ${JAVA_OPTIONS} -jar jdupdate.jar
elif test -f JDownloader.jar; then
	echo "$0: Starting JDownloader." >> ${LOG_FILE}
	exec java ${JAVA_OPTIONS} -jar JDownloader.jar $*
else
	# run updater, if JDownloader.jar does not exist
	echo "$0: No valid JDownloader.jar exist. Starting updater." >> ${LOG_FILE}
	exec java ${JAVA_OPTIONS} -jar jdupdate.jar
fi
