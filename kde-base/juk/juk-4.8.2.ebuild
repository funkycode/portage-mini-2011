# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/juk/juk-4.8.2.ebuild,v 1.1 2012/04/04 23:59:13 johu Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdemultimedia"
inherit kde4-meta

DESCRIPTION="Jukebox and music manager for KDE."
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	>=media-libs/taglib-1.6
"
RDEPEND="${DEPEND}"

src_configure() {
	# http://bugs.gentoo.org/410551 for disabling deprecated TunePimp support
	mycmakeargs=(
		-DWITH_TunePimp=OFF
	)

	kde4-meta_src_configure
}
