# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/ristretto/ristretto-0.1.0.ebuild,v 1.6 2012/01/06 10:53:18 ssuominen Exp $

EAPI=4
inherit xfconf

DESCRIPTION="Image viewer and browser for Xfce"
HOMEPAGE="http://goodies.xfce.org/projects/applications/ristretto"
SRC_URI="mirror://xfce/src/apps/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="debug"

RDEPEND="media-libs/libexif
	>=x11-libs/gtk+-2.20:2
	>=dev-libs/glib-2.24:2
	>=dev-libs/dbus-glib-0.90
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/libxfce4ui-4.8
	>=xfce-base/xfconf-4.8
	>=x11-libs/cairo-1.8"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	XFCONF=(
		--docdir=/usr/share/doc/${PF}
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog NEWS README TODO )
}
