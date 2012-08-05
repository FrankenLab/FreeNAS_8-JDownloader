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
USE_ZIP=		yes
JAVA_VERSION=		1.6+

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
#PKGMESSAGE=		${WRKSRC}/pkg-message
SUB_FILES+=		jdownloaderd
USE_RC_SUBR=		jdownloader
SUB_LIST+=		USER=${USERS}
RESTRICTED=		License does not allow selling
USERS=			www
GROUPS=			www

do-install:
	${MKDIR} ${JAVAJARDIR}/${PORTNAME}/plugins
	${INSTALL_DATA} ${WRKSRC}/lib/*.jar ${JAVAJARDIR}/${PORTNAME}/
	${MKDIR} ${PREFIX}/etc/${PORTNAME}
#.for f in profiles log4j
#	${INSTALL_DATA} ${WRKSRC}/config/$f.xml ${ETCDIR}/$f.dist.xml
#	${TEST} -e ${ETCDIR}/$f.xml ||
#		${INSTALL_DATA} ${WRKSRC}/config/$f.xml ${ETCDIR}/
#.endfor
#	${INSTALL_DATA} ${FILESDIR}/console-log4j.properties	\
#		${ETCDIR}/console-log4j.dist.properties
#	${TEST} -e ${ETCDIR}/console-log4.dist.properties ||
#		${INSTALL_DATA} ${FILESDIR}/console-log4j.properties ${ETCDIR}/
	${INSTALL_SCRIPT} ${WRKDIR}/jdownloaderd ${PREFIX}/sbin

#post-patch:
#.for FILE in ${RMMAN1}
# tools/Windows tools/linux tools/mac
#        @${RM} ${WRKDIR}/man1/${FILE}
#.endfor

post-install:
	# =========================================================
	@${FMT} ${PKGMESSAGE}
	# =========================================================

.include <bsd.port.mk>
