# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xmountains/xmountains-2.9.ebuild,v 1.4 2012/03/09 11:11:09 phajdan.jr Exp $

EAPI=4
inherit toolchain-funcs

MY_P=${P/-/_}

DESCRIPTION="Fractal terrains of snow-capped mountains near water"
HOMEPAGE="http://www.epcc.ed.ac.uk/~spb/xmountains/"
SRC_URI="http://www.epcc.ed.ac.uk/~spb/${PN}/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-misc/xbitmaps
	x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/xproto"

S=${WORKDIR}

src_prepare() {
	# add missing include for strcmp
	sed -i xmountains.c -e '1a#include <string.h> /* strcmp() */' || die
	# remove obsolete references to global.*
	sed -i Makefile.alt README -e 's|global\..||g' || die
}

src_compile() {
	emake \
		-f Makefile.alt \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		${PN}
}

src_install() {
	dobin ${PN}
	dodoc README
	newman ${PN}.man ${PN}.1
}
