# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-pt-br/ispell-pt-br-2.4-r3.ebuild,v 1.6 2012/02/05 17:53:11 armin76 Exp $

inherit eutils multilib

MY_P="br.ispell-${PV}"
DESCRIPTION="A Brazilian portuguese dictionary for ispell"
HOMEPAGE="http://www.ime.usp.br/~ueda/br.ispell"
SRC_URI="http://www.ime.usp.br/~ueda/br.ispell/${MY_P}.tar.gz
	mirror://gentoo/${P}-palavras-gentoo.diff.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~mips ppc sparc x86"
IUSE=""

DEPEND="app-text/ispell
	sys-apps/gawk"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}/${P}-palavras-gentoo.diff"
}

src_compile() {
	emake VDIR=/usr/share/dict || die
	make palavras || die
	make paradigmas || die
}

src_install() {
	dobin conjugue || die
	doman conjugue.1 || die
	insinto /usr/share/dict/
	doins verbos || die
	insinto "/usr/$(get_libdir)/ispell"
	newins br.aff pt_BR.aff || die
	newins br.hash pt_BR.hash || die
	dodoc README
}
