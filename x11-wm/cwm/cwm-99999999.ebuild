# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/cwm/cwm-99999999.ebuild,v 1.7 2012/01/29 01:54:19 xmw Exp $

EAPI=4

EGIT_REPO_URI=https://github.com/chneukirchen/cwm.git
EGIT_BRANCH=linux

inherit eutils toolchain-funcs git-2

DESCRIPTION="OpenBSD fork of calmwm, a clean and lightweight window manager"
HOMEPAGE="http://www.openbsd.org/cgi-bin/cvsweb/xenocara/app/cwm/
	http://github.com/chneukirchen/cwm"
SRC_URI=""

LICENSE="ISC"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="x11-libs/libXft
	x11-libs/libXinerama
	x11-libs/libXrandr"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/bison"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-20111229-Makefile.patch
	tc-export CC
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
	dodoc README
	make_session_desktop ${PN} ${PN}
}
