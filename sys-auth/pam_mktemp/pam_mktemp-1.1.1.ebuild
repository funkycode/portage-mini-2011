# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_mktemp/pam_mktemp-1.1.1.ebuild,v 1.9 2012/03/09 14:30:30 ranger Exp $

EAPI="4"

inherit toolchain-funcs pam

DESCRIPTION="Create per-user private temporary directories during login"
HOMEPAGE="http://www.openwall.com/pam/"
SRC_URI="http://www.openwall.com/pam/modules/${PN}/${P}.tar.gz"

LICENSE="BSD-2" # LICENSE file says "heavily cut-down 'BSD license'"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="selinux +prevent-removal"

DEPEND="virtual/pam
	selinux? ( sys-libs/libselinux )"
RDEPEND="${DEPEND}"

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} -fPIC" \
		LDFLAGS="${LDFLAGS} --shared -Wl,--version-script,\$(MAP)" \
		USE_SELINUX="$(use selinux && echo 1 || echo 0)" \
		USE_APPEND_FL="$(use prevent-removal && echo 1 || echo 0)"
}

src_install() {
	dopammod pam_mktemp.so
	dodoc README
}

pkg_postinst() {
	elog "To enable pam_mktemp put something like"
	elog
	elog "session    optional    pam_mktemp.so"
	elog
	elog "into /etc/pam.d/system-auth!"
}
