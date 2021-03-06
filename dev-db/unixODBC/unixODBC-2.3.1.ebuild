# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/unixODBC/unixODBC-2.3.1.ebuild,v 1.8 2012/03/31 18:30:32 armin76 Exp $

EAPI=4
inherit libtool

DESCRIPTION="A complete ODBC driver manager"
HOMEPAGE="http://www.unixodbc.org/"
SRC_URI="http://ftp.unixodbc.org/pub/${PN}/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris"
IUSE="+minimal odbcmanual static-libs"

RDEPEND=">=sys-devel/libtool-2.2.6b
	>=sys-libs/readline-6.1
	>=sys-libs/ncurses-5.7-r7
	virtual/libiconv"
DEPEND="${RDEPEND}
	sys-devel/flex"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	elibtoolize
}

src_configure() {
	# --enable-driver-conf is --enable-driverc as per configure.in
	econf \
		--sysconfdir="${EPREFIX}"/etc/${PN} \
		$(use_enable static-libs static) \
		$(use_enable !minimal drivers) \
		$(use_enable !minimal driverc)
}

src_install() {
	default

	use prefix && dodoc README*
	use odbcmanual && dohtml -a css,gif,html,sql,vsd -r doc/*

	find "${ED}" -name '*.la' -exec sed -i -e "/^dependency_libs/s:=.*:='':" {} +
}
