# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-soundmenu-plugin/xfce4-soundmenu-plugin-0.4.1.ebuild,v 1.1 2012/03/15 03:49:00 ssuominen Exp $

EAPI=4
inherit xfconf

DESCRIPTION="A panel plug-in to control MPRIS2 compatible players like Pragha (from the same authors)"
HOMEPAGE="https://github.com/matiasdelellis/xfce4-soundmenu-plugin"
SRC_URI="mirror://github/matiasdelellis/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +glyr lastfm"

RDEPEND=">=dev-libs/dbus-glib-0.98
	>=dev-libs/keybinder-0.2.2
	>=x11-libs/gtk+-2.20:2
	x11-libs/libX11
	>=xfce-base/libxfce4ui-4.8
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/xfce4-panel-4.8
	glyr? ( >=media-libs/glyr-0.9.4 )
	lastfm? ( >=media-libs/libclastfm-0.4_p2012 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	XFCONF=(
		--disable-static
		$(use_enable lastfm libclastfm)
		$(use_enable glyr libglyr)
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog NEWS README THANKS TODO )
}
