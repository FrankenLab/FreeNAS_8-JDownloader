# New ports collection makefile for:	jdownloader
# Date created:		2012-08-03
# Whom:			ProtoSD <sdproto@gmail.com>
#
# $FreeBSD$
#
#

PORTNAME=	JDownloader
DISTVERSION=	0.9.581
CATEGORIES=	net java www
MASTER_SITES=	http://94.23.204.158/
DISTNAME=	${PORTNAME}

MAINTAINER=	sdproto@gmail.com
COMMENT=	Captures links and manages downloading targets

RUN_DEPENDS=	unzip:${PORTSDIR}/archivers/unzip unrar:${PORTSDIR}/archivers/unrar wget:${PORTSDIR}/ftp/wget

NO_BUILD=		yes
USE_JAVA=		yes
JAVA_VENDOR=		openjdk
USE_ZIP=		yes
JAVA_VERSION=		1.7+
JAVA_RUN=		yes

#USE_DISPLAY=		yes
# If set, this ports requires a (virtual) X11 environment
# setup. If the environment variable DISPLAY Is not set,
# then an extra build dependency on Xvfb is added. Further,
# if PACKAGE_BUILDING is not set, then CONFIGURE_ENV and
# MAKE_ENV are extended with a DISPLAY variable.

# USE_RC_SUBR
# If set, the ports startup/shutdown script uses the common
# routines found in /etc/rc.subr.
# If this is set to a list of files, these files will be
# automatically added to ${SUB_FILES}, some %%VAR%%'s will
# automatically be expanded, they will be installed in
# ${PREFIX}/etc/rc.d and added to the packing list.

WRKSRC=			${WRKDIR}/${PORTNAME}
DATADIR=        	${JAVASHAREDIR}/${PORTNAME}
#PKGMESSAGE=		${WRKSRC}/pkg-message
SUB_FILES+=		pkg-message jdownloaderd
USE_RC_SUBR=		jdownloader
SUB_LIST+=		USER=${USERS}
RESTRICTED=		License does not allow selling
USERS=			www
GROUPS=			www

post-extract:
	@${RM} -f ${WRKDIR}/JDownloader/JDownloader.exe
	@${RM} -f ${WRKDIR}/JDownloader/JDownloaderBETA.exe
	@${RM} -f ${WRKDIR}/JDownloader/JDownloaderD3D.exe
	@${RM} -f ${WRKDIR}/JDownloader/JDUpdate.exe
	@${RM} -f ${WRKDIR}/JDownloader/windows_createlog.bat
	@${RM} -f ${WRKDIR}/JDownloader/windows_restore.bat
	@${RM} -f ${WRKDIR}/JDownloader/plugins/jdshutdown/windows/shutdown.exe
	@${RM} -rf ${WRKDIR}/JDownloader/tools/Windows
	@${RM} -rf ${WRKDIR}/JDownloader/tools/linux
	@${RM} -rf ${WRKDIR}/JDownloader/tools/mac

do-install:
#/usr/local/share/java/JDownloader/workspace/FreeNAS_8-JDownloader/nanobsd/plugins/jdownloader_pbi/resources/usr/ports/net/jdownloader/work/JDownloader/JDownloader.jar
#	${MKDIR} ${JAVAJARDIR}/${PORTNAME}/plugins
#	${MKDIR} ${DATADIR}
#	${INSTALL_DATA} ${WRKSRC}/ ${DATADIR}/
#	${INSTALL_DATA} ${WRKSRC}/lib/*.jar ${JAVAJARDIR}/${PORTNAME}/
#	${MKDIR} ${PREFIX}/etc/${PORTNAME}
	@${ECHO_MSG} "DATADIR is:"
	@${ECHO_MSG} ${DATADIR}
	@${ECHO_MSG} "PREFIX is:"
	@${ECHO_MSG} ${PREFIX}
	@${ECHO_MSG} "WRKSRC is:"
	@${ECHO_MSG} ${WRKSRC}
	@${ECHO_MSG} "WRKDIR is:"
	@${ECHO_MSG} ${WRKDIR}
	@${ECHO_MSG} " "
	(cd ${WRKSRC}/ && ${COPYTREE_SHARE} \* ${DATADIR})
#	${COPYTREE_SHARE} ${WRKSRC}/* ${DATADIR}/
	${INSTALL_SCRIPT} ${WRKDIR}/jdownloaderd ${PREFIX}/sbin

#do-install:
#        @${ECHO_MSG} -n ">> Installing scripts..."
#        @${INSTALL_SCRIPT} ${WRKDIR}/${PORTNAME}.script.sh ${PREFIX}/bin/${PORTNAME}
#        @${ECHO_MSG} " [ DONE ]"
#
#.for d in datamodeler ide jdbc jdev jlib modules rdbms sleepycat \
#    sqldeveloper timingframework
#        @${ECHO_MSG} -n ">> Installing data directory '${d}'..."
#        @cd ${WRKSRC} && ${FIND} ${d} -type d \
#                -not -path "jdev/extensions/oracle.jdeveloper.subversion/licenses" \
#                -exec ${MKDIR} ${DATADIR}/\{} \;
#        @cd ${WRKSRC} && ${FIND} ${d} -type f \
#                -not -name "*.orig" \
#                -not -name "*.exe" \
#                -not -name "*.bat" \
#                -not -name "*.bak" \
#                -not -name "*.dll" \
#                -not -path "jdev/extensions/oracle.jdeveloper.subversion/licenses/*" \
#                -exec ${INSTALL_DATA} \{} ${DATADIR}/\{} \;
#        @${ECHO_MSG} " [ DONE ]"
#.endfor

#.for f in profiles log4j
#	${INSTALL_DATA} ${WRKSRC}/config/$f.xml ${ETCDIR}/$f.dist.xml
#	${TEST} -e ${ETCDIR}/$f.xml ||
#		${INSTALL_DATA} ${WRKSRC}/config/$f.xml ${ETCDIR}/
#.endfor

#.if !exists(${DISTDIR}/${DIST_SUBDIR}/${DISTNAME}${EXTRACT_SUFX})
#DISTFILE_INSTRUCTIONS   =       \n
#DISTFILE_INSTRUCTIONS   +=      Due to Oracle license restrictions, you must fetch the source \n
#DISTFILE_INSTRUCTIONS   +=      distribution manually.  Please access  \n
#DISTFILE_INSTRUCTIONS   +=      http://www.oracle.com/technetwork/developer-tools/datamodeler/downloads/index.html \n
#DISTFILE_INSTRUCTIONS   +=      with a web browser and follow the link for the \n
#DISTFILE_INSTRUCTIONS   +=      \"${DISTFILES}\".  \n
#DISTFILE_INSTRUCTIONS   +=      You will be required to register and log in, \n
#DISTFILE_INSTRUCTIONS   +=      but you can create an account on that page.  \n
#.endif

#.for FILE in ${NONUNIX}
# tools/Windows tools/linux tools/mac
#	@${RM} ${WRKDIR}/${FILE}
#.endfor

post-install:
	# =========================================================
	@${FMT} ${PKGMESSAGE}
	# =========================================================

.include <bsd.port.mk>
