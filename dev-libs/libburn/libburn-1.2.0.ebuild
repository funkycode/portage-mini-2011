# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libburn/libburn-1.2.0.ebuild,v 1.2 2012/03/10 08:05:22 billie Exp $

EAPI=4

DESCRIPTION="Libburn is an open-source library for reading, mastering and writing optical discs."
HOMEPAGE="http://libburnia-project.org"
SRC_URI="http://files.libburnia-project.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86"
IUSE="cdio debug static-libs track-src-odirect"

RDEPEND="cdio? ( >=dev-libs/libcdio-0.83 )"
DEPEND="$RDEPEND
	dev-util/pkgconfig"

src_configure() {
	econf \
	$(use_enable static-libs static) \
	$(use_enable track-src-odirect) \
	$(use_enable cdio libcdio) \
	--disable-ldconfig-at-install \
	$(use_enable debug)
}

src_install() {
	default

	dodoc CONTRIBUTORS doc/{comments,*.txt}

	cd "${S}"/cdrskin
	docinto cdrskin
	dodoc *.txt README
	docinto cdrskin/html
	dohtml cdrskin_eng.html

	find "${D}" -name '*.la' -exec rm -rf '{}' '+' || die "la removal failed"
}
