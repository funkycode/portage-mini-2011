# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mednafen/mednafen-0.8.13.3-r1.ebuild,v 1.2 2012/02/18 08:16:13 radhermit Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="An advanced NES, GB/GBC/GBA, TurboGrafx 16/CD, NGPC and Lynx emulator"
HOMEPAGE="http://mednafen.sourceforge.net/"
SRC_URI="mirror://sourceforge/mednafen/mednafen-${PV/13/D}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="alsa altivec cjk debug jack nls"

RDEPEND="virtual/opengl
	media-libs/libsndfile
	dev-libs/libcdio
	media-libs/libsdl[audio,joystick,video]
	media-libs/sdl-net
	sys-libs/zlib[minizip]
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${PN}

src_prepare() {
	sed -i \
		-e 's:$(datadir)/locale:/usr/share/locale:' \
		$(find . -name 'Makefile.am') \
		intl/Makefile.in \
		|| die 'sed failed'
	sed -i \
		-e '/-fomit-frame-pointer/d' \
		-e '/-ffast-math/d' \
		-e '/CPPFLAGS=.*CFLAGS/s/CFLAGS/CXXFLAGS/' \
		-e '/^AX_CFLAGS_GCC_OPTION.*OPTIMIZER_FLAGS/d' \
		configure.ac \
		|| die "sed failed"
	epatch "${FILESDIR}"/${P}-zlib.patch
	epatch "${FILESDIR}"/${P}-zlib-1.2.6.patch
	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable alsa) \
		$(use_enable altivec) \
		$(use_enable cjk cjk-fonts) \
		$(use_enable debug debugger) \
		$(use_enable jack) \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc Documentation/cheats.txt AUTHORS ChangeLog TODO
	dohtml Documentation/*
	prepgamesdirs
}
