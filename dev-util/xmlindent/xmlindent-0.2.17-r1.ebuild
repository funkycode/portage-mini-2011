# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xmlindent/xmlindent-0.2.17-r1.ebuild,v 1.3 2012/04/09 16:00:04 ago Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="XML Indent is an XML stream reformatter written in ANSI C, analogous to GNU indent."
HOMEPAGE="http://xmlindent.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmlindent/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~sparc x86"

IUSE=""
DEPEND="sys-devel/flex"
RDEPEND=""

src_prepare() {
	sed -i Makefile \
		-e 's|gcc|$(CC)|g' \
		-e 's|-g|$(CFLAGS) $(LDFLAGS) |g' \
		|| die "sed failed"
}

src_compile() {
	tc-export CC
	emake || die "emake failed"
}

src_install() {
	dobin xmlindent || die "dobin failed"
	doman *.1
}
