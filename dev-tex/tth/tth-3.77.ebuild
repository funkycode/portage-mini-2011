# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/tth/tth-3.77.ebuild,v 1.12 2012/03/08 21:22:30 ranger Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="Translate TEX into HTML"
HOMEPAGE="http://hutchinson.belmont.ma.us/tth/"
SRC_URI="mirror://gentoo/${P}.tgz"

SLOT="0"
LICENSE="free-noncomm"
KEYWORDS="~alpha amd64 ppc ppc64 x86"
IUSE=""

DEPEND=""
RDEPEND="
	app-text/ghostscript-gpl
	media-libs/netpbm"

S="${WORKDIR}/tth_C"

src_compile() {
	echo 'all: tth' > Makefile || die
	tc-export CC
	emake
}

src_install() {
	dobin tth latex2gif ps2gif ps2png
	dodoc CHANGES
	doman tth.1
	dohtml *
}
