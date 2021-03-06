# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pragha/pragha-1.0.1.ebuild,v 1.1 2012/03/15 03:43:02 ssuominen Exp $

EAPI=4
inherit xfconf

DESCRIPTION="A lightweight music player for the Xfce desktop environment"
HOMEPAGE="http://pragha.wikispaces.com/ http://github.com/matiasdelellis/pragha"
SRC_URI="mirror://github/matiasdelellis/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +glyr lastfm"

COMMON_DEPEND="dev-db/sqlite:3
	>=dev-libs/dbus-glib-0.92
	>=dev-libs/glib-2.16.3
	dev-libs/keybinder
	>=dev-libs/libcdio-0.78
	media-libs/gst-plugins-base:0.10
	>=media-libs/libcddb-1.2.1
	>=media-libs/taglib-1.7-r1
	>=net-misc/curl-7.18
	x11-libs/libX11
	>=x11-libs/libnotify-0.7
	>=xfce-base/exo-0.6.0
	glyr? ( >=media-libs/glyr-0.9.4 )
	lastfm? ( >=media-libs/libclastfm-0.4_p2012 )"
RDEPEND="${COMMON_DEPEND}
	media-plugins/gst-plugins-meta:0.10"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	XFCONF=(
		$(use_enable debug)
		$(use_enable lastfm libclastfm)
		$(use_enable glyr libglyr)
		)
}

src_prepare() {
	sed -i -e '/CFLAGS/s:-O3 -Werror::' configure || die
	sed -i -e '/Catego/s:Player:&;:' data/${PN}.desktop || die
	xfconf_src_prepare
}

src_install() {
	xfconf_src_install docdir=/usr/share/doc/${PF}
}
