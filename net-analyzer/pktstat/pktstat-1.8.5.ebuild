# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/pktstat/pktstat-1.8.5.ebuild,v 1.1 2012/03/04 22:22:37 radhermit Exp $

EAPI=4

DESCRIPTION="A network monitoring tool, with bandwidth tracking"
HOMEPAGE="http://www.adaptive-enterprises.com.au/~d/software/pktstat/"
SRC_URI="http://www.adaptive-enterprises.com.au/~d/software/pktstat/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="net-libs/libpcap
	>=sys-libs/ncurses-5.3-r1"
DEPEND="${RDEPEND}"

src_install() {
	dosbin pktstat
	doman pktstat.1
	dodoc ChangeLog NEWS README TODO
}
