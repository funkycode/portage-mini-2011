# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/galaxy/galaxy-2.0.ebuild,v 1.2 2011/12/28 12:21:18 xarthisius Exp $

EAPI=4

inherit fdo-mime toolchain-funcs

DESCRIPTION="stellar simulation program"
HOMEPAGE="http://kornelix.squarespace.com/galaxy/"
SRC_URI="http://kornelix.squarespace.com/storage/downloads/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/gtk+:2"
RDEPEND="${DEPEND}
	x11-misc/xdg-utils"

pkg_setup() {
	tc-export CXX
}

src_prepare() {
	sed -e '/DOCDIR/ s/PROGRAM)/&-\$(VERSION)/g' \
		-e '/xdg-desktop-menu/d' \
		-i Makefile || die
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
