# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dropbox/dropbox-1.2.13.ebuild,v 1.2 2012/02/15 19:20:40 jlec Exp $

EAPI='3'

DESCRIPTION="Dropbox daemon (pretends to be GUI-less)"
HOMEPAGE="http://dropbox.com/"
SRC_URI="x86? ( http://dl-web.dropbox.com/u/17/dropbox-lnx.x86-${PV}.tar.gz )
	amd64? ( http://dl-web.dropbox.com/u/17/dropbox-lnx.x86_64-${PV}.tar.gz )"

LICENSE="CCPL-Attribution-NoDerivs-3.0 FTL MIT LGPL-2 openssl dropbox"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror strip"

QA_EXECSTACK_x86="opt/dropbox/_ctypes.so"
QA_EXECSTACK_amd64="opt/dropbox/_ctypes.so"

DEPEND=""
RDEPEND="net-misc/wget"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/.dropbox-dist" "${S}" || die
}

src_install() {
	insinto /usr/share/icons
	doins -r icons/* || die
	rm -rf icons || die

	local targetdir="/opt/dropbox"
	insinto "${targetdir}" || die
	doins -r * || die
	fperms a+x "${targetdir}/dropbox" || die
	fperms a+x "${targetdir}/dropboxd" || die
	dosym "${targetdir}/dropboxd" "/opt/bin/dropbox" || die
}
