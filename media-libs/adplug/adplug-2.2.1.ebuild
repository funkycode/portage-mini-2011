# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/adplug/adplug-2.2.1.ebuild,v 1.6 2012/03/07 20:34:16 ranger Exp $

EAPI=4

DESCRIPTION="A free, cross-platform, hardware independent AdLib sound player library"
HOMEPAGE="http://adplug.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="debug static-libs"

RDEPEND=">=dev-cpp/libbinio-1.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS=( AUTHORS BUGS ChangeLog NEWS README TODO )

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable debug)
}

src_install() {
	default
	rm -f "${ED}"usr/lib*/lib${PN}.la
}
