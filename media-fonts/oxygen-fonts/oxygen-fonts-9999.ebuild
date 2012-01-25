# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit git-2 font

EGIT_REPO_URI="git://anongit.kde.org/oxygen-fonts"
HOMEPAGE="http://www.kde.org/"
DESCRIPTION="Oxygen Fonts"
KEYWORDS="alpha amd64 ~amd64 arm ia64 ppc ppc64 s390 sh sparc x86 ~x86"
SLOT="0"
LICENSE="OSL"

S="${WORKDIR}"

DOCS="README"

src_install() {
	FONT_S=${S}/Monospace FONT_SUFFIX="ttf" font_src_install
	FONT_S=${S}/Oxygen-Regular FONT_SUFFIX="ttf" font_src_install
	FONT_S=${S}/Oxygen-Bold FONT_SUFFIX="ttf" font_src_install
}