# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeplasma-addons/kdeplasma-addons-4.8.1.ebuild,v 1.4 2012/04/04 17:59:00 ago Exp $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="Extra Plasma applets and engines."
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2 LGPL-2"

KEYWORDS="amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="attica debug desktopglobe exif fcitx ibus qalculate qwt scim semantic-desktop"

# krunner is only needed to generate dbus interface for lancelot
COMMON_DEPEND="
	app-crypt/qca:2
	app-crypt/qca-ossl:2
	$(add_kdebase_dep kdelibs 'semantic-desktop=')
	$(add_kdebase_dep krunner)
	$(add_kdebase_dep plasma-workspace 'semantic-desktop=')
	x11-misc/shared-mime-info
	attica? ( dev-libs/libattica )
	desktopglobe? ( $(add_kdebase_dep marble) )
	exif? ( $(add_kdebase_dep libkexiv2) )
	fcitx? ( app-i18n/fcitx[dbus] )
	ibus? ( app-i18n/ibus )
	qalculate? ( sci-libs/libqalculate )
	qwt? ( x11-libs/qwt:5 )
	scim? ( app-i18n/scim )
	semantic-desktop? (
		$(add_kdebase_dep kdepimlibs 'semantic-desktop')
		$(add_kdebase_dep plasma-workspace 'rss')
	)
"
DEPEND="${COMMON_DEPEND}
	dev-cpp/eigen:2
"
RDEPEND="${COMMON_DEPEND}
"

# bug 410253
RESTRICT="test"

src_prepare() {
	use semantic-desktop || epatch "${FILESDIR}/${PN}-4.6.2-optional-akonadi.patch"
	kde4-base_src_prepare
}

src_configure() {
	mycmakeargs=(
		-DDBUS_INTERFACES_INSTALL_DIR="${EPREFIX}/usr/share/dbus-1/interfaces/"
		$(cmake-utils_use_with attica LibAttica)
		$(cmake-utils_use_with desktopglobe Marble)
		$(cmake-utils_use_with exif Kexiv2)
		$(cmake-utils_use_with ibus)
		$(cmake-utils_use_with qalculate)
		$(cmake-utils_use_with qwt)
		$(cmake-utils_use_with semantic-desktop KdepimLibs)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with scim)
	)

	kde4-base_src_configure
}
