# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/packagekit/packagekit-0.6.20.ebuild,v 1.2 2012/01/28 17:17:21 lxnay Exp $

EAPI="3"

MY_PN="PackageKit"
MY_P=${MY_PN}-${PV}

DESCRIPTION="PackageKit Package Manager interface (meta package)"
HOMEPAGE="http://www.packagekit.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="gtk qt4"

RDEPEND="gtk? ( ~app-admin/packagekit-gtk-${PV} )
	qt4? ( ~app-admin/packagekit-qt4-${PV} )"

DEPEND="${RDEPEND}"
