# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/siphon/siphon-666.ebuild,v 1.15 2012/02/05 18:29:41 armin76 Exp $

IUSE=""
MY_P=${PN}-v.${PV}

DESCRIPTION="A portable passive network mapping suite"
SRC_URI="http://siphon.datanerds.net/${MY_P}.tar.gz"
HOMEPAGE="http://siphon.datanerds.net/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~ppc x86"

DEPEND="net-libs/libpcap"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${MY_P}
	sed -i "s:osprints\.conf:/etc/osprints.conf:" log.c
	sed -i "s:^CFLAGS = .*$:CFLAGS = ${CFLAGS} -pthread -ggdb -I.:" Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dobin siphon
	insinto /etc
	doins osprints.conf
	dodoc LICENSE README
}
