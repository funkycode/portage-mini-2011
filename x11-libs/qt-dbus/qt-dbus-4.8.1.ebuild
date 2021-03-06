# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-dbus/qt-dbus-4.8.1.ebuild,v 1.2 2012/03/30 14:48:08 pesa Exp $

EAPI=4

inherit qt4-build

DESCRIPTION="The DBus module for the Qt toolkit"
SLOT="4"
if [[ ${PV} != 4*9999 ]]; then
	KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
else
	KEYWORDS=""
fi
IUSE=""

DEPEND="
	>=sys-apps/dbus-1.2
	~x11-libs/qt-core-${PV}[aqua=,c++0x=,debug=,qpa=]
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-4.7-qdbusintegrator-no-const.patch"
)

pkg_setup() {
	QT4_TARGET_DIRECTORIES="
		src/dbus
		tools/qdbus/qdbus
		tools/qdbus/qdbusxml2cpp
		tools/qdbus/qdbuscpp2xml"

	if [[ ${PV} != 4*9999 ]]; then
		QT4_EXTRACT_DIRECTORIES="${QT4_TARGET_DIRECTORIES}
			include/QtCore
			include/QtDBus
			include/QtXml
			src/corelib
			src/xml"
	fi

	QCONFIG_ADD="dbus dbus-linked"
	QCONFIG_DEFINE="QT_DBUS"

	qt4-build_pkg_setup
}

src_configure() {
	myconf+=" -dbus-linked"

	qt4-build_src_configure
}
