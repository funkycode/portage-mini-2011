# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-screenshooter/xfce4-screenshooter-1.8.0.ebuild,v 1.10 2012/04/09 18:34:12 ssuominen Exp $

EAPI=4
EAUTORECONF=yes
inherit multilib xfconf

DESCRIPTION="Xfce4 screenshooter application and panel plugin"
HOMEPAGE="http://goodies.xfce.org/projects/applications/xfce4-screenshooter"
SRC_URI="mirror://xfce/src/apps/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.16
	>=net-libs/libsoup-2.26
	>=x11-libs/gdk-pixbuf-2.16
	>=x11-libs/gtk+-2.16:2
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXfixes
	>=xfce-base/exo-0.6
	>=xfce-base/xfce4-panel-4.8
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/libxfce4ui-4.8"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

pkg_setup() {
	PATCHES=( "${FILESDIR}"/${P}-underlinking.patch )

	XFCONF=(
		--libexecdir="${EPREFIX}"/usr/$(get_libdir)
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
		$(xfconf_use_debug)
		--enable-xfixes
		)

	DOCS=( AUTHORS ChangeLog NEWS README TODO )
}

src_prepare() {
	sed -i -e 's:$(datadir)/xfce4/doc:$(docdir)/html:' Makefile.am || die
	xfconf_src_prepare
}
