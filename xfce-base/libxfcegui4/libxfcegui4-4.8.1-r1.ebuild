# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/libxfcegui4/libxfcegui4-4.8.1-r1.ebuild,v 1.1 2012/03/31 10:00:48 ssuominen Exp $

EAPI=4
inherit xfconf

DESCRIPTION="This package has been replaced by libxfce4ui. You shouldn't be using this."
HOMEPAGE="http://www.xfce.org/"
SRC_URI="mirror://xfce/src/xfce/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~x64-solaris"
IUSE="glade startup-notification"

RDEPEND="gnome-base/libglade
	x11-libs/libSM
	x11-libs/libX11
	>=x11-libs/gtk+-2.10:2
	>=xfce-base/libxfce4util-4.8
	glade? ( dev-util/glade:3 )
	startup-notification? ( x11-libs/startup-notification )"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	dev-util/pkgconfig"

pkg_setup() {
	PATCHES=( "${FILESDIR}"/${P}-deprecated.patch )

	XFCONF=(
		--disable-static
		$(use_enable startup-notification)
		$(use_enable glade gladeui)
		--with-html-dir="${EPREFIX}"/deprecated
		)
}

src_install() {
	xfconf_src_install
	rm -rf "${ED}"/deprecated
}
