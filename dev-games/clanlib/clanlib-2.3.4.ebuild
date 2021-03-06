# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/clanlib/clanlib-2.3.4.ebuild,v 1.2 2012/02/07 10:02:38 tupone Exp $

EAPI=2
inherit flag-o-matic eutils autotools-utils

MY_P=ClanLib-${PV}

DESCRIPTION="multi-platform game development library"
HOMEPAGE="http://www.clanlib.org/"
SRC_URI="http://clanlib.org/download/releases-2.0/${MY_P}.tgz"

LICENSE="ZLIB"
SLOT="2.3"
KEYWORDS="~amd64 ~x86" #not big endian safe #82779
IUSE="doc ipv6 mikmod opengl sound sqlite sse2 static-libs vorbis X"

RDEPEND="sys-libs/zlib
	X? (
		media-libs/libpng
		virtual/jpeg
		media-libs/freetype
		media-libs/fontconfig
		opengl? ( virtual/opengl )
		app-arch/bzip2
		x11-libs/libX11
	)
	sqlite? ( dev-db/sqlite )
	sound? ( media-libs/alsa-lib )
	mikmod? (
		media-libs/libmikmod
		media-libs/alsa-lib
	)
	vorbis? (
		media-libs/libogg
		media-libs/libvorbis
		media-libs/alsa-lib
	)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen dev-lang/perl )"

S="${WORKDIR}"/${MY_P}

PATCHES=( "${FILESDIR}"/${P}-autotools.patch )
AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1
DOCS=(
	CODING_STYLE
	CREDITS
	PATCHES
	README
)

src_configure() {
	myeconfargs=(
		--disable-dependency-tracking
		$(use_enable doc docs)
		$(use_enable sse2)
		$(use_enable opengl clanGL)
		$(use_enable opengl clanGL1)
		$(use_enable opengl clanGUI)
		$(use_enable X clanDisplay)
		$(use_enable vorbis clanVorbis)
		$(use_enable mikmod clanMikMod)
		$(use_enable sqlite clanSqlite)
		$(use_enable ipv6 getaddr)
	)
	use sound \
		|| use vorbis \
		|| use mikmod \
		|| myeconfargs+=( --disable-clanSound )
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile
	use doc && autotools-utils_src_compile html
}

# html files are keeped in a directory that is dependent on the SLOT
# so to keep eventual bookmarks to the doc from version to version
src_install() {
	autotools-utils_src_install
	if use doc ; then
		emake DESTDIR="${D}" install-html || die "emake html-install failed"
		cp -r Examples Resources "${D}"/usr/share/doc/${PF}/ \
			|| die "Copying failed"
	fi
}
