# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/liberation-fonts/liberation-fonts-1.07.2.ebuild,v 1.6 2012/04/01 15:34:52 armin76 Exp $

EAPI=4

inherit font

DESCRIPTION="A GPL-2 Helvetica/Times/Courier replacement TrueType font set, courtesy of Red Hat"
HOMEPAGE="https://fedorahosted.org/liberation-fonts"
SRC_URI="!fontforge? ( https://fedorahosted.org/releases/l/i/${PN}/${PN}-ttf-${PV}.tar.gz )
fontforge? ( https://fedorahosted.org/releases/l/i/${PN}/${P}.tar.gz )"

KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
SLOT="0"
LICENSE="GPL-2-with-exceptions"
IUSE="fontforge X"

FONT_SUFFIX="ttf"

FONT_CONF=( "${FILESDIR}/60-liberation.conf" )

DEPEND="
	fontforge? ( media-gfx/fontforge )
	app-arch/unzip
"
RDEPEND=""

pkg_setup() {
	if use fontforge; then
		FONT_S="${S}/${PN}-ttf-${PV}"
	else
		FONT_S="${WORKDIR}/${PN}-ttf-${PV}"
		S="${FONT_S}"
	fi
	font_pkg_setup
}
