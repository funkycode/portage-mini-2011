# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/debugedit/debugedit-5.3.5-r1.ebuild,v 1.1 2012/01/25 19:28:35 vapier Exp $

# To recreate this tarball, just grab latest rpm5 release:
#	http://rpm5.org/files/rpm/
# The files are in tools/
# Or see $FILESDIR/update.sh

EAPI="2"

inherit toolchain-funcs eutils

DESCRIPTION="standalone debugedit taken from rpm"
HOMEPAGE="http://www.rpm5.org/"
SRC_URI="http://dev.gentoo.org/~swegener/distfiles/${P}.tar.bz2
	http://dev.gentoo.org/~vapier/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-libs/popt
	dev-libs/elfutils
	dev-libs/beecrypt"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-5.3.5-DWARF-4.patch #400663
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	dobin debugedit || die
}
