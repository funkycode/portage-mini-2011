# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/moreutils/moreutils-0.45-r1.ebuild,v 1.7 2012/04/07 17:51:24 maekke Exp $

EAPI=4
inherit eutils toolchain-funcs prefix

DESCRIPTION="a growing collection of the unix tools that nobody thought to write thirty years ago"
HOMEPAGE="http://kitenet.net/~joey/code/moreutils/"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~ppc ~ppc64 x86 ~x86-linux"
IUSE="+doc +perl"

RDEPEND="
	perl? (
		dev-lang/perl
		dev-perl/IPC-Run
		dev-perl/Time-Duration
		dev-perl/TimeDate
	)"
DEPEND="
	doc? (
		dev-lang/perl
		>=app-text/docbook2X-0.8.8-r2
		app-text/docbook-xml-dtd:4.4
	)"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.45-dtd-path.patch
	eprefixify *.docbook

	# Don't build manpages
	if ! use doc ; then
		sed -i -e '/^all:/s/$(MANS)//' -e '/man1/d' Makefile || die
	fi

	# Don't install perl scripts
	if ! use perl ; then
		sed -i -e '/PERLSCRIPTS/d' Makefile || die
	fi
}

src_compile() {
	tc-export CC
	emake CFLAGS="${CFLAGS}" DOCBOOK2XMAN=docbook2man.pl PREFIX="${EPREFIX}/usr"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" INSTALL_BIN=install install

	# sys-process is more advanced than parallel from moreutils, rename it
	if use doc; then
		mv -vf "${ED}"usr/share/man/man1/{,${PN}_}parallel.1 || die
	fi
	mv -vf "${ED}"usr/bin/{,${PN}_}parallel || die
}
