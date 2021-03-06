# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/whois/whois-5.0.8.ebuild,v 1.9 2011/12/15 20:28:35 grobian Exp $

EAPI=3
inherit eutils toolchain-funcs

MY_P=${P/-/_}
DESCRIPTION="improved Whois Client"
HOMEPAGE="http://www.linux.it/~md/software/"
SRC_URI="mirror://debian/pool/main/w/whois/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="iconv idn nls"
RESTRICT="test" #59327

RDEPEND="idn? ( net-dns/libidn )"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-4.7.2-config-file.patch

	if use nls ; then
		sed -i -e 's:#\(.*pos\):\1:' Makefile
	else
		sed -i -e '/ENABLE_NLS/s:define:undef:' config.h
	fi

	echo "int main() {}" | $(tc-getCC) ${CFLAGS} ${LDFLAGS} -xc -o /dev/null - -lcrypt >& /dev/null \
		|| sed -i -e 's/-lcrypt//' Makefile
}

src_configure() { :;} # expected no-op

src_compile() {
	unset HAVE_ICONV HAVE_LIBIDN
	use iconv && export HAVE_ICONV=1
	use idn && export HAVE_LIBIDN=1
	tc-export CC
	emake CFLAGS="${CFLAGS} ${CPPFLAGS}" || die
}

src_install() {
	emake BASEDIR="${D}" prefix="${EPREFIX}"/usr install || die
	insinto /etc
	doins whois.conf
	dodoc README debian/changelog

	if [[ ${USERLAND} != "GNU" ]]; then
		mv "${ED}"/usr/share/man/man1/{whois,mdwhois}.1
		mv "${ED}"/usr/bin/{whois,mdwhois}
	fi
}
