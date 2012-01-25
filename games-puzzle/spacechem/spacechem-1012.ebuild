# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit games eutils

DESCRIPTION="A design-based puzzle game from Zachtronics Industries"
HOMEPAGE="http://spacechemthegame.com/"
SRC_URI="SpaceChem-${PV}.tar.gz"

LICENSE="SPACECHEM"
SLOT="0"
KEYWORDS="-* x86 amd64"
IUSE=""
RESTRICT="fetch strip"

RDEPEND=">=dev-lang/mono-2
	x11-misc/xclip
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
		amd64? (
		app-emulation/emul-linux-x86-sdl
		)"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Fetch ${SRC_URI} and put it into ${DISTDIR}. If this is your"
	einfo "first time installing SpaceChem, be sure to have your license"
	einfo "key close by, as the game will ask for it when first started."
	einfo "Purchase the game from http://spacechemthegame.com/"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	unpack ./SpaceChem-i386.deb
	unpack ./data.tar.gz
}

src_install() {
	cd ${S}/opt/zachtronicsindustries/spacechem
	chmod +x spacechem-launcher.sh
	dodoc readme/PRIVACY.txt readme/SOUND-CREDITS.txt
	domenu zachtronicsindustries-spacechem.desktop
	rm -r readme
	rm zachtronicsindustries-spacechem.desktop
	newicon icon.png zachtronicsindustries-spacechem.png
	cd ${S}
	mv opt ${D}

	prepgamesdirs
}
