# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/udpcast/udpcast-20090920.ebuild,v 1.5 2011/05/08 20:26:51 jer Exp $

EAPI=2

DESCRIPTION="Multicast file transfer tool"
HOMEPAGE="http://udpcast.linux.lu/"
SRC_URI="http://udpcast.linux.lu/download/${P}.tar.bz2"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND=""

src_prepare() {
	sed -i \
		-e "/^LDFLAGS +=-s/d" \
		Makefile.in || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc *.txt
}
