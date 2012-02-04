# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils games

DESCRIPTION="Action/adventure game set in a destructable world made of voxels"
HOMEPAGE="http://www.lexaloffle.com/voxatron.php"
SRC_URI="VoxatronLinux_${PV}_i386.tar.gz"

LICENSE="Voxatron"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE="opengl"
RESTRICT="fetch strip"

RDEPEND="media-libs/libsdl
	media-libs/alsa-lib
	media-libs/libsndfile[-minimal]
	x11-base/xorg-server[-minimal]
	opengl? ( virtual/opengl media-libs/mesa )
		amd64? (
			app-emulation/emul-linux-x86-baselibs
			app-emulation/emul-linux-x86-sdl
			app-emulation/emul-linux-x86-soundlibs
			app-emulation/emul-linux-x86-xlibs
			opengl? ( app-emulation/emul-linux-x86-opengl )
			)"

S=${WORKDIR}/voxatron
dir=/opt/voxatron

pkg_nofetch() {
	elog "Fetch ${SRC_URI} and move or link it"
	elog "in ${DISTDIR}"
	elog "Purchase the game from http://www.lexaloffle.com/voxatron.php"
}

src_unpack() {
	unpack "${A}"
	cd "${S}"
}

src_install() {
	mkdir -p ${D}/${dir}
	dodoc vox.txt
	rm -r *.txt
	doicon lexaloffle-vox.png
	chmod +x vox
	mv vox* ${D}/${dir}
	games_make_wrapper "voxatron" "${dir}/vox" "${dir}" "${dir}"
	make_desktop_entry "voxatron" "Voxatron" "lexaloffle-vox" "Game;ActionGame;AdventureGame" "Comment=${DESCRIPTION}"

	prepgamesdirs
}
