# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktux/ktux-4.8.1.ebuild,v 1.2 2012/04/04 18:59:16 ago Exp $

EAPI=4

KMNAME="kdetoys"
inherit kde4-meta

DESCRIPTION="KDE: screensaver featuring the Space-Faring Tux"
KEYWORDS="amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

# libkworkspace - only as a stub to provide KDE4Workspace config
DEPEND="
	$(add_kdebase_dep kscreensaver)
	$(add_kdebase_dep libkworkspace)
"
RDEPEND="${DEPEND}"
