# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/fsviewer/fsviewer-0.2.5.ebuild,v 1.11 2011/11/12 10:43:57 jlec Exp $

EAPI=1

inherit eutils

MY_PN=FSViewer

DESCRIPTION="file system viewer for Window Maker"
HOMEPAGE="http://www.bayernline.de/~gscholz/linux/fsviewer/"
SRC_URI="http://www.bayernline.de/~gscholz/linux/${PN}/${MY_PN}.app-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="
	dev-libs/expat
	media-libs/tiff:0
	media-libs/giflib
	media-libs/libpng:0
	media-libs/fontconfig
	media-libs/freetype
	sys-libs/zlib
	virtual/jpeg
	x11-libs/libPropList
	x11-libs/libSM
	x11-libs/libICE
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXft
	x11-libs/libXmu
	x11-libs/libXpm
	x11-libs/libXrender
	x11-libs/libXt
	x11-proto/xextproto
	x11-proto/xproto
	x11-wm/windowmaker"

S=${WORKDIR}/${MY_PN}.app-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-windowmaker.patch
}

src_compile() {
	econf --with-appspath=/usr/lib/GNUstep \
		--with-extralibs=-lXft
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
}
