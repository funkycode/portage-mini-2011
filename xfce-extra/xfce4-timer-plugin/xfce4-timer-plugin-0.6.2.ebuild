# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-timer-plugin/xfce4-timer-plugin-0.6.2.ebuild,v 1.12 2012/03/21 06:13:52 ssuominen Exp $

EAPI=4
inherit xfconf

DESCRIPTION="A simple timer plug-in for the Xfce desktop environment"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-timer-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/${PV%.*}/${P}.tar.bz2
	mirror://gentoo/${P}-ca.po.bz2
	mirror://gentoo/${P}-hr.po.bz2
	mirror://gentoo/${P}-nl.po.bz2
	mirror://gentoo/${P}-sk.po.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE=""

RDEPEND=">=xfce-base/xfce4-panel-4.8
	>=xfce-base/libxfcegui4-4.8
	>=xfce-base/libxfce4util-4.8"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	DOCS=( AUTHORS ChangeLog README TODO )
}

src_prepare() {
	local po
	for po in ca hr nl sk; do
		mv -vf "${WORKDIR}"/${P}-${po}.po po/${po}.po || die
	done

	xfconf_src_prepare
}
