# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pth/pth-2.0.7-r3.ebuild,v 1.6 2012/01/11 11:03:18 scarabeus Exp $

EAPI=4

inherit eutils fixheadtails libtool flag-o-matic

DESCRIPTION="GNU Portable Threads"
HOMEPAGE="http://www.gnu.org/software/pth/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="debug static-libs"

DEPEND=""
RDEPEND="${DEPEND}"

DOCS="ANNOUNCE AUTHORS ChangeLog NEWS README THANKS USERS"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.0.5-parallelfix.patch
	epatch "${FILESDIR}"/${PN}-2.0.6-ldflags.patch
	epatch "${FILESDIR}"/${PN}-2.0.6-sigstack.patch
	epatch "${FILESDIR}"/${PN}-2.0.7-parallel-install.patch
	epatch "${FILESDIR}"/${PN}-2.0.7-ia64.patch

	ht_fix_file aclocal.m4 configure

	elibtoolize
}

src_configure() {
	# bug 350815
	( use arm || use sh ) && append-flags -U_FORTIFY_SOURCE

	local conf
	use debug && conf="${conf} --enable-debug"	# have a bug --disable-debug and shared
	econf \
		${conf} \
		$(use_enable static-libs static)
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
}
