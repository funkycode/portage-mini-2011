# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sflowtool/sflowtool-3.25.ebuild,v 1.1 2012/03/28 14:57:26 jer Exp $

EAPI=4
inherit autotools flag-o-matic

DESCRIPTION="sflowtool is a utility for collecting and processing sFlow data"
HOMEPAGE="http://www.inmon.com/technology/sflowTools.php"
SRC_URI="http://www.inmon.com/bin/${P}.tar.gz"

LICENSE="inmon-sflow"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DOCS=( AUTHORS ChangeLog NEWS README )

src_prepare() {
	epatch "${FILESDIR}"/${PN}-3.20-ctype-header.patch
	eautoreconf
}

src_configure() {
	append-flags -DSPOOFSOURCE
	econf
}
