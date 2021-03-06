# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/regexxer/regexxer-0.10.ebuild,v 1.2 2011/12/22 13:50:55 ssuominen Exp $

EAPI=4
GCONF_DEBUG=no
inherit autotools eutils gnome2

DESCRIPTION="An interactive tool for performing search and replace operations"
HOMEPAGE="http://regexxer.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-cpp/glibmm-2.28
	dev-cpp/gtkmm:3.0
	dev-cpp/gtksourceviewmm:3.0"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-sandbox.patch
	eautoreconf
	gnome2_src_prepare
}
