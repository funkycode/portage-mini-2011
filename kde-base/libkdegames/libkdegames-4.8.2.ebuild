# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdegames/libkdegames-4.8.2.ebuild,v 1.1 2012/04/04 23:59:00 johu Exp $

EAPI=4

KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="Base library common to many KDE games."
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	>=dev-games/ggz-client-libs-0.0.14
"
RDEPEND="${DEPEND}"

KMSAVELIBS="true"

PATCHES=(
	"${FILESDIR}"/${PN}-4.2.0-darwin.patch
)
