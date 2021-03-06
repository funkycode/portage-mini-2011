# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ncdc/ncdc-9999.ebuild,v 1.4 2012/02/28 13:06:38 xmw Exp $

EAPI=4

EGIT_REPO_URI="git://g.blicky.net/ncdc.git"

inherit autotools base git-2

DESCRIPTION="ncurses directconnect client"
HOMEPAGE="http://dev.yorhel.nl/ncdc"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="app-arch/bzip2
	dev-db/sqlite:3
	dev-lang/perl
	dev-libs/glib:2
	dev-libs/libxml2:2
	net-libs/glib-networking
	sys-libs/gdbm
	sys-libs/ncurses:5"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/makeheaders"

src_prepare() {
	eautoreconf
}
