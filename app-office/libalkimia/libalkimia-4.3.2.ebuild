# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/libalkimia/libalkimia-4.3.2.ebuild,v 1.2 2012/04/04 19:33:59 ago Exp $

EAPI="4"

inherit kde4-base

DESCRIPTION="Library with common classes and functionality used by KDE finance applications"
HOMEPAGE="http://kde-apps.org/content/show.php/libalkimia?content=137323"
SRC_URI="http://kde-apps.org/CONTENT/content-files/137323-${P}.tar.bz2"

LICENSE="LGPL-2.1"
KEYWORDS="amd64 ~x86"
SLOT="0"
IUSE="doc"

RDEPEND="dev-libs/gmp[cxx]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

PATCHES=(
	"${FILESDIR}/${PN}-4.3.2-doc.patch"
)

src_configure() {
	mycmakeargs=( $(cmake-utils_use_build doc) )
	kde4-base_src_configure
}
