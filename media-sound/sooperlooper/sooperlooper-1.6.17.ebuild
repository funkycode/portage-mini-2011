# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sooperlooper/sooperlooper-1.6.17.ebuild,v 1.1 2011/06/09 09:50:09 radhermit Exp $

EAPI=4
inherit autotools eutils wxwidgets toolchain-funcs

DESCRIPTION="Live looping sampler with immediate loop recording"
HOMEPAGE="http://essej.net/sooperlooper/index.html"
SRC_URI="http://essej.net/sooperlooper/${P/_p/-}.tar.gz
	mirror://gentoo/${PN}-1.6.5-m4.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="media-sound/jack-audio-connection-kit
	x11-libs/wxGTK:2.8
	media-libs/liblo
	dev-libs/libsigc++:1.2
	media-libs/libsndfile
	media-libs/libsamplerate
	dev-libs/libxml2
	media-libs/rubberband
	sci-libs/fftw:3.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${P/_p*}

DOCS=( OSC README )

src_prepare() {
	cp -rf "${WORKDIR}"/aclocal "${S}" || die "copying aclocal failed"
	epatch "${FILESDIR}"/${PN}-1.6.5-cxxflags.patch

	AT_M4DIR="${S}"/aclocal eautoreconf
	cd "${S}"/libs/midi++
	AT_M4DIR="${S}"/aclocal eautoreconf
	cd "${S}"/libs/pbd
	AT_M4DIR="${S}"/aclocal eautoreconf
}

src_compile() {
	emake AR=$(tc-getAR)
}

src_configure() {
	WX_GTK_VER="2.8"
	need-wxwidgets unicode

	econf \
		--disable-optimize \
		--with-wxconfig-path="${WX_CONFIG}"
}
