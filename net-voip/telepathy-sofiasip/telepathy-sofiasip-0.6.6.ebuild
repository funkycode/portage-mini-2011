# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-sofiasip/telepathy-sofiasip-0.6.6.ebuild,v 1.5 2011/03/22 20:11:31 ranger Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit python

DESCRIPTION="A SIP connection manager for Telepathy based around the Sofia-SIP library."
HOMEPAGE="http://telepathy.freedesktop.org/"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE="test"

RDEPEND=">=net-libs/sofia-sip-1.12.10
	>=net-libs/telepathy-glib-0.8.0
	>=dev-libs/glib-2.16
	sys-apps/dbus
	dev-libs/dbus-glib"

DEPEND="${RDEPEND}
	dev-libs/libxslt
	test? ( dev-python/twisted )"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	python_convert_shebangs -r 2 .
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die
}
