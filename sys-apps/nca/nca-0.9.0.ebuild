# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/nca/nca-0.9.0.ebuild,v 1.2 2010/07/21 00:29:13 sbriesen Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Network Console on Acid"
HOMEPAGE="http://www.xenoclast.org/nca/"
SRC_URI="http://www.xenoclast.org/nca/download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/openssl
	sys-libs/zlib"

DEPEND="dev-lang/perl
	${RDEPEND}"

src_prepare() {
	sed -i -e "s:^\([[:space:]]\+\$(MAKE) install\):\1 DESTDIR=\$(DESTDIR):g" \
		-e "s:=\(\$(CFLAGS)\):=\"\1\":g" -e "s:=\(\$(CC)\):=\"\1\":g" Makefile

	sed -i -e "s:-s sshd:sshd:g" ncad.patch
}

src_compile() {
	emake -j1 CFLAGS="${CFLAGS}" CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	dodir /sbin
	emake BINDIR="${D}sbin" MANDIR="${D}usr/share/man" SYSCONF_DIR="${D}etc" \
		DESTDIR="${D}" install_nca install_ssh install_man

	newinitd "${FILESDIR}/ncad.initd" ncad
	dodoc ChangeLog README* rc/ncad.template
}
