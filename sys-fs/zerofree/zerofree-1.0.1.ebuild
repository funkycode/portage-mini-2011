# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/zerofree/zerofree-1.0.1.ebuild,v 1.1 2012/03/11 13:13:32 kumba Exp $

EAPI="4"
inherit eutils toolchain-funcs

DESCRIPTION="Zero's out all free space on a filesystem."
HOMEPAGE="http://intgat.tigress.co.uk/rmy/uml/index.html"
SRC_URI="http://intgat.tigress.co.uk/rmy/uml/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~mips"
IUSE=""

DEPEND="sys-libs/e2fsprogs-libs"
RDEPEND="${DEPEND}"

src_prepare() {
	# Honor system CFLAGS.
	sed -i \
		-e "s:CC=gcc:CC=$(tc-getCC)\nCFLAGS=${CFLAGS}\nLDFLAGS=${LDFLAGS}:g" \
		-e "s:-o zerofree:\$(CFLAGS) \$(LDFLAGS) -o zerofree:g" \
		Makefile || die "Failed to sed the Makefile"
}

src_compile() {
	# Just a Makefile, nothing fancy.
	make || die "Failed to compile ${PN}."
}

src_install() {
	# Install into /sbin
	into /
	dosbin zerofree
}
