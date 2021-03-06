# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/pigz/pigz-2.1.7.ebuild,v 1.1 2011/12/18 20:56:54 spatz Exp $

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="A parallel implementation of gzip"
HOMEPAGE="http://www.zlib.net/pigz/"
SRC_URI="http://www.zlib.net/pigz/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~sparc ~x86 ~amd64-linux ~sparc64-solaris"
IUSE="symlink test"

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}
	test? ( app-arch/ncompress )"

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i -e '1,3d' -e '5s/$(CC)/$(CC) $(LDFLAGS)/' "${S}/Makefile" || die
	tc-export CC
}

src_install() {
	dobin ${PN}
	dosym /usr/bin/${PN} /usr/bin/un${PN}
	dodoc README
	doman ${PN}.1

	if use symlink; then
		dosym /usr/bin/${PN} /usr/bin/gzip
		dosym /usr/bin/un${PN} /usr/bin/gunzip
	fi
}
