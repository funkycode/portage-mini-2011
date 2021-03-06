# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kdenlive/kdenlive-0.8.2.1.ebuild,v 1.4 2012/03/16 18:01:34 tomka Exp $

EAPI=4
KDE_LINGUAS="ca cs da de el es et fi fr gl he hr hu it nl pl pt pt_BR ru sl tr
uk zh zh_CN zh_TW"
KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="Kdenlive! (pronounced Kay-den-live) is a Non Linear Video Editing Suite for KDE."
HOMEPAGE="http://www.kdenlive.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 ~ppc x86 ~x86-linux"
IUSE="debug semantic-desktop"

RDEPEND="
	dev-libs/qjson
	>=media-libs/mlt-0.7.6[ffmpeg,sdl,xml,melt,qt4,kde]
	virtual/ffmpeg[encode,sdl,X]
	$(add_kdebase_dep kdelibs 'semantic-desktop?')
"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS README )

PATCHES=(
	"${FILESDIR}/${P}-qt48.patch"
)

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with semantic-desktop Nepomuk)
	)

	kde4-base_src_configure
}
