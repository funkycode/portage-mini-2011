# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/fancytasks/fancytasks-1.0.98.ebuild,v 1.2 2012/03/03 13:52:31 johu Exp $

EAPI=4
KDE_LINGUAS="de en_GB es et fr km nds pl pt ru sv tr uk"
KDE_LINGUAS_DIR=( applet/locale containment/locale )
KDE_MINIMAL="4.8"
inherit kde4-base

DESCRIPTION="Task and launch representation plasmoid"
HOMEPAGE="http://kde-look.org/content/show.php/Fancy+Tasks?content=99737"
SRC_URI="http://kde-look.org/CONTENT/content-files/99737-${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep plasma-workspace)
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXext
"
RDEPEND="${DEPEND}"

DOCS=( CHANGELOG README TODO )
