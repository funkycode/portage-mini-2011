# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konsolekalendar/konsolekalendar-4.8.2.ebuild,v 1.1 2012/04/04 23:59:27 johu Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdepim"
KMMODULE="console/${PN}"
KDE_SCM="git"
inherit kde4-meta

DESCRIPTION="A command line interface to KDE calendars"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep kdepim-common-libs)
"
RDEPEND="${DEPEND}"

KMLOADLIBS="kdepim-common-libs"
