# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/soundkonverter/soundkonverter-1.4.0.ebuild,v 1.1 2012/03/20 14:19:44 johu Exp $

EAPI=4
KDE_LINGUAS="cs de es_AR et fr hu pt"
inherit kde4-base

DESCRIPTION="Frontend to various audio converters"
HOMEPAGE="http://www.kde-apps.org/content/show.php/soundKonverter?content=29024"
SRC_URI="http://kde-apps.org/CONTENT/content-files/29024-${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkcddb)
	$(add_kdebase_dep libkcompactdisc)
	media-libs/taglib
	media-sound/cdparanoia
"
RDEPEND="${DEPEND}"
