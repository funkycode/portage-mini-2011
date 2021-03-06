# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libticonv/libticonv-1.1.3.ebuild,v 1.1 2012/02/19 13:32:28 xarthisius Exp $

EAPI=4

inherit multilib

DESCRIPTION="Charset conversion library for TI calculators"
HOMEPAGE="http://lpg.ticalc.org/prj_tilp/"
SRC_URI="mirror://sourceforge/tilp/tilp2-linux/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc iconv static-libs"

RDEPEND="dev-libs/glib:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS=( AUTHORS LOGO NEWS README ChangeLog docs/api.txt )

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable iconv)
}

src_install() {
	default
	if use doc; then
		dohtml docs/html/*
		docinto charsets
		dohtml docs/charsets/*
	fi
	use static-libs || rm -f "${D}"/usr/$(get_libdir)/${PN}.la
}
