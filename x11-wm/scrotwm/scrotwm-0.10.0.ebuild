# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/scrotwm/scrotwm-0.10.0.ebuild,v 1.1 2012/01/27 15:42:32 xmw Exp $

EAPI=3

inherit eutils multilib toolchain-funcs

DESCRIPTION="Small dynamic tiling window manager for X11"
HOMEPAGE="http://www.scrotwm.org"
SRC_URI="http://opensource.conformal.com/snapshots/${PN}/${P}.tgz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-misc/dmenu"
DEPEND="${DEPEND}
	x11-libs/libX11
	x11-libs/libXrandr
	x11-libs/libXtst"

S=${WORKDIR}/${P}/linux

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
	tc-export CC
}

src_install() {
	emake PREFIX="${D}"usr LIBDIR="${D}usr/$(get_libdir)"  install || die
}
