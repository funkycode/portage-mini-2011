# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/librouteros/librouteros-1.1.2.ebuild,v 1.1 2011/12/30 20:16:49 maksbotan Exp $

EAPI=4

inherit base autotools-utils autotools

DESCRIPTION="Library for accessing MikroTik's RouterOS via its API"
HOMEPAGE="http://verplant.org/librouteros/"
SRC_URI="http://verplant.org/librouteros/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug static-libs"

DEPEND="dev-libs/libgcrypt"
RDEPEND="${DEPEND}"

DOCS=(README AUTHORS)
PATCHES=("${FILESDIR}"/disable_werror.patch)

src_prepare(){
	base_src_prepare
	eautoreconf
}
