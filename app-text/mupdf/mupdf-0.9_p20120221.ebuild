# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mupdf/mupdf-0.9_p20120221.ebuild,v 1.5 2012/04/07 22:10:06 xmw Exp $

EAPI=4

inherit eutils flag-o-matic multilib toolchain-funcs

DESCRIPTION="a lightweight PDF viewer and toolkit written in portable C"
HOMEPAGE="http://mupdf.com/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux"
IUSE="X vanilla"

RDEPEND="media-libs/freetype:2
	media-libs/jbig2dec
	virtual/jpeg
	media-libs/openjpeg
	X? ( x11-libs/libX11
		x11-libs/libXext )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	default
	mv mupdf-* ${P} || die
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.8.165-buildsystem.patch

	if ! use vanilla ; then
		epatch "${FILESDIR}"/${PN}-9999-zoom-1.patch
	fi
}

src_compile() {
	use X || my_nox11="NOX11=yes MUPDF= "

	emake CC="$(tc-getCC)" \
		build=debug verbose=true ${my_nox11} -j1
}

src_install() {
	emake prefix="${ED}usr" libdir="${ED}usr/$(get_libdir)" \
		build=debug verbose=true ${my_nox11} install

	insinto /usr/include
	doins pdf/mupdf.h fitz/fitz.h xps/muxps.h || die

	insinto /usr/$(get_libdir)/pkgconfig
	doins debian/mupdf.pc

	if use X ; then
		domenu debian/mupdf.desktop
		doicon debian/mupdf.xpm
	fi
}
