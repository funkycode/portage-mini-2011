# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/mhash/mhash-0.9.9.9-r1.ebuild,v 1.5 2012/04/01 14:43:44 armin76 Exp $

EAPI=4
inherit eutils

DESCRIPTION="library providing a uniform interface to a large number of hash algorithms"
HOMEPAGE="http://mhash.sourceforge.net/"
SRC_URI="mirror://sourceforge/mhash/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="static-libs"

RDEPEND=""
DEPEND="dev-lang/perl" # pod2html

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-0.9.9-fix-{mem-leak,snefru-segfault,whirlpool-segfault}.patch \
		"${FILESDIR}"/${PN}-0.9.9-autotools-namespace-stomping.patch \
		"${FILESDIR}"/${P}-remove_premature_free.patch \
		"${FILESDIR}"/${P}-force64bit-tiger.patch \
		"${FILESDIR}"/${P}-align.patch \
		"${FILESDIR}"/${P}-alignment.patch
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_compile() {
	default
	emake -C doc mhash.html
}

src_install() {
	default

	use static-libs || rm -f "${ED}"usr/lib*/libmhash.la
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO \
		doc/{example.c,skid2-authentication}
	dohtml doc/mhash.html
}
