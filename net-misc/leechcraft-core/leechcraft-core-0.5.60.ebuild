# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-core/leechcraft-core-0.5.60.ebuild,v 1.1 2012/03/20 12:42:09 maksbotan Exp $

EAPI="4"

EGIT_REPO_URI="git://github.com/0xd34df00d/leechcraft.git"
EGIT_PROJECT="leechcraft-${PV}"

inherit confutils leechcraft

DESCRIPTION="Core of LeechCraft, the modular network client"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +sqlite postgres"

DEPEND=">=dev-libs/boost-1.39
		x11-libs/qt-core
		x11-libs/qt-gui
		x11-libs/qt-script
		x11-libs/qt-sql[postgres?,sqlite?]"
RDEPEND="${DEPEND}
		x11-libs/qt-svg"

pkg_setup() {
	confutils_require_any postgres sqlite
}

src_configure() {
	local mycmakeargs="
		-DWITH_PLUGINS=False"
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	make_desktop_entry leechcraft "LeechCraft" leechcraft.png
}
