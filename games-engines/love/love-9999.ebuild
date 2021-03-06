# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/love/love-9999.ebuild,v 1.2 2012/03/08 00:01:40 chithanh Exp $

EAPI=3

inherit games

DESCRIPTION="A framework for 2D games in Lua"
HOMEPAGE="http://love2d.org/"

if [[ ${PV} == 9999* ]]; then
	inherit autotools mercurial
	EHG_REPO_URI="https://bitbucket.org/rude/${PN}"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://bitbucket.org/rude/${PN}/downloads/${P}-linux-src.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="ZLIB"
SLOT="0"
IUSE=""

RDEPEND="dev-games/physfs
	dev-lang/lua
	media-libs/devil[mng,tiff]
	media-libs/freetype
	media-libs/libmodplug
	media-libs/libsdl[joystick,opengl]
	media-libs/libvorbis
	media-libs/openal
	media-sound/mpg123
	virtual/opengl"
DEPEND="${RDEPEND}
	media-libs/libmng
	media-libs/tiff"

DOCS=( "readme.md" "changes.txt" )

src_prepare() {
	sh platform/unix/gen-makefile || die
	mkdir platform/unix/m4 || die
	eautoreconf
}
