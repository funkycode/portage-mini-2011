# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/grpn/grpn-1.3.4.ebuild,v 1.1 2012/01/03 21:18:24 ssuominen Exp $

EAPI=4
inherit eutils toolchain-funcs

DESCRIPTION="A reverse polish notation (RPN) calculator based on GTK+ and libmath"
HOMEPAGE="http://www.getreu.net/"
SRC_URI="http://www.getreu.net/public/downloads/software/${PN}/${P}/${PN}_${PV}-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	x11-libs/libX11"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	sed -i -e 's:= -g -O2 -I/usr/X11/include:+=:' Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" DFLAGS="${LDFLAGS}"
}

src_install() {
	dobin ${PN}
	doman ${PN}.1

	newicon icon.png ${PN}.png
	make_desktop_entry ${PN} "RPN calculator"
}
