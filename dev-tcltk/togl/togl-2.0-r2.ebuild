# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/togl/togl-2.0-r2.ebuild,v 1.9 2012/02/24 23:26:15 ssuominen Exp $

EAPI=4

MY_P=Togl${PV}

DESCRIPTION="A Tk widget for OpenGL rendering"
HOMEPAGE="http://togl.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}-src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug +threads"

RDEPEND="
	dev-lang/tk
	virtual/opengl"
DEPEND="${RDEPEND}"

# tests directory is missing
RESTRICT="test"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed \
		-e 's:-fomit-frame-pointer::g' \
		-e 's:-O2::g' \
		-e 's:-pipe::g' \
		-i configure || die
}

src_configure() {
	econf \
		$(use_enable debug symbols) \
		$(use_enable threads)
}

src_install() {
	emake DESTDIR="${D}" install
	dohtml doc/*
	dodoc README*
}
