# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-remoteosd/vdr-remoteosd-0.1.1.ebuild,v 1.2 2012/02/07 14:06:28 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin

DESCRIPTION="VDR: remoteosd PlugIn"
HOMEPAGE="http://vdr.schmirler.de/"
SRC_URI="http://vdr.schmirler.de/remoteosd/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0
		>=media-plugins/vdr-svdrpservice-0.0.2"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i menu.h \
		-e 's-"../svdrpservice/svdrpservice.h"-<svdrpservice/svdrpservice.h>-'

	vdr-plugin_src_prepare
}
