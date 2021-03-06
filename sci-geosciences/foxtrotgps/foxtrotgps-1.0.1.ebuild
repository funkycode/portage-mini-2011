# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/foxtrotgps/foxtrotgps-1.0.1.ebuild,v 1.2 2011/07/24 11:28:39 scarabeus Exp $

EAPI=4

inherit base

DESCRIPTION="Foxtrotgps is an easy to use, fast and lightweight mapping application. (fork of tangogps)"
HOMEPAGE="http://www.foxtrotgps.org/"
SRC_URI="http://www.foxtrotgps.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/libxml2:2
	gnome-base/gconf:2
	media-libs/libexif
	net-misc/curl
	>=sci-geosciences/gpsd-2.90
	sys-apps/dbus
	x11-libs/gtk+:2
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"

PATCHES=(
	"${FILESDIR}"/${PN}-curl-7.21.7.patch
)
