# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/zen-sources/zen-sources-2.6.38_p20110510.ebuild,v 1.1 2011/05/10 15:17:36 hwoarang Exp $

EAPI="2"

COMPRESSTYPE=".lzma"
K_USEPV="yes"
UNIPATCH_STRICTORDER="yes"
K_SECURITY_UNSUPPORTED="1"

CKV="${PV/_p[0-9]*}"
ETYPE="sources"
inherit kernel-2
detect_version
K_NOSETEXTRAVERSION="don't_set_it"

DESCRIPTION="The Zen Kernel Sources v2.6"
HOMEPAGE="http://zen-kernel.org"

ZEN_FILE="zen-patch-${PV}.diff.gz"
ZEN_URI="http://dev.gentoo.org/~hwoarang/distfiles/${ZEN_FILE}"
TUXONICE_FILE="tuxonice-3.2-for-$(get_version_component_range 1-3).patch.bz2"
TUXONICE_URI="tuxonice? ( http://tuxonice.net/files/${TUXONICE_FILE} )"
SRC_URI="${KERNEL_URI} ${ZEN_URI} ${TUXONICE_URI}"

KEYWORDS="-* ~amd64 ~ppc ~ppc64 ~x86"
IUSE="tuxonice"

DEPEND="|| ( app-arch/xz-utils app-arch/lzma-utils )"
RDEPEND=""

KV_FULL="${PVR/_p/-zen}"
S="${WORKDIR}"/linux-"${KV_FULL}"

pkg_setup(){
	ewarn
	ewarn "${PN} is *not* supported by the Gentoo Kernel Project in any way."
	ewarn "If you need support, please contact the Zen developers directly."
	ewarn "Do *not* open bugs in Gentoo's bugzilla unless you have issues with"
	ewarn "the ebuilds. Thank you."
	ewarn
	ebeep 8
	kernel-2_pkg_setup
}

src_prepare(){
	epatch "${DISTDIR}"/"${ZEN_FILE}"
	if use tuxonice; then
		epatch "${DISTDIR}"/${TUXONICE_FILE}
	fi
}

K_EXTRAEINFO="For more info on zen-sources and details on how to report problems, see: \
${HOMEPAGE}. You may also visit #zen-sources on irc.rizon.net"
