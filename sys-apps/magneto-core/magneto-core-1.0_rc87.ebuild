# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/magneto-core/magneto-core-1.0_rc87.ebuild,v 1.1 2012/02/12 07:28:08 lxnay Exp $

EAPI="3"
PYTHON_DEPEND="2"
inherit eutils python multilib

DESCRIPTION="Entropy Package Manager notification applet library"
HOMEPAGE="http://www.sabayon.org"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

SRC_URI="mirror://sabayon/sys-apps/entropy-${PV}.tar.bz2"
S="${WORKDIR}/entropy-${PV}/magneto"

DEPEND=">=sys-apps/entropy-client-services-${PV}"
RDEPEND="${DEPEND}
	x11-misc/xdg-utils"

src_compile() {
	einfo "nothing to compile"
}

src_install() {
	emake DESTDIR="${D}" LIBDIR="usr/lib" magneto-core-install || die "make install failed"
}

pkg_postinst() {
	python_mod_optimize "/usr/$(get_libdir)/entropy/magneto"
}

pkg_postrm() {
	python_mod_cleanup "/usr/$(get_libdir)/entropy/magneto"
}
