# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libticalcs2/libticalcs2-1.1.7.ebuild,v 1.1 2012/02/19 13:49:32 xarthisius Exp $

EAPI=4

inherit eutils multilib

DESCRIPTION="Library for communication with TI calculators"
HOMEPAGE="http://lpg.ticalc.org/prj_tilp/"
SRC_URI="mirror://sourceforge/tilp/tilp2-linux/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc nls static-libs"

RDEPEND="dev-libs/glib:2
	>=sci-libs/libticables2-1.3.3
	>=sci-libs/libticonv-1.1.3
	>=sci-libs/libtifiles2-1.1.5
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

DOCS=( AUTHORS LOGO NEWS README ChangeLog docs/api.txt )

src_configure() {
	econf \
		--disable-rpath \
		$(use_enable nls) \
		$(use_enable static-libs static)
}

src_install() {
	default
	use doc && dohtml docs/html/*
	use static-libs || rm "${D}"/usr/$(get_libdir)/${PN}.la
}
