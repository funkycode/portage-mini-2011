# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/mm/mm-1.4.2-r1.ebuild,v 1.9 2012/03/18 18:49:35 armin76 Exp $

EAPI="2"

inherit multilib

DESCRIPTION="Shared Memory Abstraction Library"
HOMEPAGE="http://www.ossp.org/pkg/lib/mm/"
SRC_URI="ftp://ftp.ossp.org/pkg/lib/mm/${P}.tar.gz"

LICENSE="as-is"
SLOT="1.2"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

src_prepare() {
	sed -i Makefile.in \
		-e '/--mode=link/s| -o | $(LDFLAGS)&|g' \
		|| die "sed Makefile.in"
}

src_test() {
	emake test || die "testing problem"
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc README ChangeLog INSTALL PORTING THANKS
}

pkg_postinst() {
	ewarn 'if you upgraded from mm-1.3 or earlier please run:'
	ewarn "revdep-rebuild --library \"/usr/$(get_libdir)/libmm.so.13\""
}
