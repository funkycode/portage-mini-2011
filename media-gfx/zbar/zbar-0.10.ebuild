# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit autotools eutils

DESCRIPTION="Library and tools for reading barcodes from images or video"
HOMEPAGE="http://zbar.sourceforge.net/"
SRC_URI="mirror://sourceforge/zbar/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk +imagemagick +jpeg python qt4 +threads +v4l2 X +xv"

RDEPEND="
	gtk? ( =dev-libs/glib-2* =x11-libs/gtk+-2* )
	imagemagick? ( >=media-gfx/imagemagick-6.2.6 )
	jpeg? ( virtual/jpeg )
	python? (
		>=dev-lang/python-2.3
		gtk? ( dev-python/pygtk )
	)
	qt4? ( x11-libs/qt-core x11-libs/qt-gui )
	v4l2? ( media-libs/libv4l )
	X? (
		x11-libs/libXext
		xv? ( x11-libs/libXv )
	)
"

DEPEND="${RDEPEND}"

src_prepare() {
	# do not install LICENSE file
	epatch "${FILESDIR}/${P}-no-std-docs.patch"
	epatch "${FILESDIR}/${P}-use-libv4l.patch"
	eautoreconf
}

src_configure() {
	local conf

	econf ${conf} \
		--docdir=/usr/share/doc/${PF} \
		$(use_enable v4l2 video) \
		$(use_enable threads pthread) \
		$(use_with jpeg) \
		$(use_with gtk) \
		$(use_with imagemagick) \
		$(use_with python) \
		$(use_with qt4 qt) \
		$(use_with X x) \
		$(use_with xv xv)
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc HACKING INSTALL NEWS README TODO
}
