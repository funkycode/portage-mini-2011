# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fox-wrapper/fox-wrapper-3.ebuild,v 1.5 2012/03/08 15:40:40 naota Exp $

DESCRIPTION="wrapper for fox-config to manage multiple versions"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND=""

S=${WORKDIR}

src_install() {
	exeinto /usr/lib/misc
	newexe "${FILESDIR}"/fox-wrapper-${PV}.sh fox-wrapper.sh || die

	dodir /usr/bin
	dosym ../lib/misc/fox-wrapper.sh /usr/bin/fox-config
}
