# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pkgconfig-openbsd/pkgconfig-openbsd-20120116.ebuild,v 1.3 2012/01/17 00:46:08 ssuominen Exp $

# cvs -d anoncvs@anoncvs.openbsd.org:/cvs get src/usr.bin/pkg-config/pkg-config
# cvs -d anoncvs@anoncvs.openbsd.org:/cvs get src/usr.bin/pkg-config/pkg-config.1
# cvs -d anoncvs@anoncvs.openbsd.org:/cvs get src/usr.sbin/pkg_add/OpenBSD/PkgConfig.pm

EAPI=4

DESCRIPTION="A perl based version of pkg-config from OpenBSD"
HOMEPAGE="http://www.openbsd.org/cgi-bin/cvsweb/src/usr.bin/pkg-config/ http://www.openbsd.org/cgi-bin/cvsweb/src/usr.sbin/pkg_add/OpenBSD/PkgConfig.pm"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.tar.xz"

LICENSE="ISC"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-lang/perl
	virtual/perl-Getopt-Long"
DEPEND=""

S=${WORKDIR}/src

src_prepare() {
	# Config.pm from dev-lang/perl doesn't set ARCH, only archname
	sed -i -e '/Config/s:ARCH:archname:' usr.bin/pkg-config/pkg-config || die
}

src_install() {
	newbin usr.bin/pkg-config/pkg-config pkg-config-openbsd
	newman usr.bin/pkg-config/pkg-config.1 pkg-config-openbsd.1

	insinto /usr/share/${PN}/OpenBSD
	doins usr.sbin/pkg_add/OpenBSD/PkgConfig.pm

	cat <<-EOF > "${T}"/99${PN}
	COLON_SEPARATED=PERL5LIB
	PERL5LIB=/usr/share/${PN}
	EOF

	doenvd "${T}"/99${PN}
}
