# Copyright 1999-2011 Funtoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit versionator

MY_PV=$(get_version_component_range 1-2)

DESCRIPTION="Dynamic XDG menu for openbox"
HOMEPAGE="http://mimasgpc.free.fr/openbox-menu.html"
SRC_URI="http://mimarchlinux.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="lxde-base/menu-cache
lxde-base/lxmenu-data"

RDEPEND="${DEPEND}"

src_compile() {
	cd ${S}
	emake
}

src_install() {
	dobin openbox-menu
}
