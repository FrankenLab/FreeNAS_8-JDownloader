# New ports collection makefile for:	jdownloader
# Date created:		2012-08-03
# Whom:			R. Tristanaux <sdproto@gmail.com>
#
# $FreeBSD$
#
#

PORTNAME=	JDownloader
DISTVERSION=	0.9.334
CATEGORIES=	net java www
MASTER_SITES=	http://94.23.204.158/
DISTNAME=	${PORTNAME}

MAINTAINER=	sdproto@gmail.com
COMMENT=	Captures HTML links and manages downloading targets

RUN_DEPENDS=	unzip:${PORTSDIR}/archivers/unzip unrar:${PORTSDIR}/archivers/unrar wget:${PORTSDIR}/ftp/wget

NO_BUILD=		yes
USE_JAVA=		yes
JAVA_VENDOR=		openjdk
USE_ZIP=		yes
JAVA_VERSION=		1.6
JAVA_RUN=		yes

OPTIONS=		XVFB "Enable Virtual X Display for JDownloader"	On

WRKSRC=			${WRKDIR}/${PORTNAME}
DATADIR=        	${JAVASHAREDIR}/${PORTNAME}
SUB_FILES+=		pkg-message jdownloader
USE_RC_SUBR=		jdownloaderd
SUB_LIST+=		USER=${USERS}
RESTRICTED=		License does not allow selling
USERS=			www
GROUPS=			www
PID_FILE=		/var/run/${PORTNAME}/${PORTNAME}.pid

.include <bsd.port.options.mk>

# Xvfb
.if defined(WITH_XVFB)
RUN_DEPENDS+=	Xvfb:${PORTSDIR}/x11-servers/xorg-vfbserver \
		x11vnc:${PORTSDIR}/net/x11vnc
.endif

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
	@(cd ${WRKSRC}/ && ${COPYTREE_SHARE} \* ${DATADIR})
	@${INSTALL} -o ${USERS} -g ${GROUPS} ${WRKDIR}/jdownloader ${PREFIX}/sbin/
	${CP} ${WRKDIR}/jdownloader ${PREFIX}/JDOWNLOADER.example
	@${INSTALL} -d -o ${USERS} -g ${GROUPS} -m 0750 /var/run/${PORTNAME} /var/log/${PORTNAME}
#	${CHOWN} -R ${USERS}:${GROUPS} /var/log/${PORTNAME} /var/run/${PORTNAME}

.if !exists(${DISTDIR}/${DIST_SUBDIR}/${DISTNAME}${EXTRACT_SUFX})
DISTFILE_INSTRUCTIONS   =       \n
DISTFILE_INSTRUCTIONS   +=      Download the distfile from http://94.23.204.158/JDownloader.zip\n
DISTFILE_INSTRUCTIONS   +=      and copy it to /usr/ports/distfiles.\n
.endif

post-install:
	# =========================================================
	@${FMT} ${PKGMESSAGE}
	# =========================================================

.include <bsd.port.mk>
