# Copyright 2008-2012 Funtoo Technologies
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils multilib python

DESCRIPTION="Disper is an on-the-fly display switch utility"
HOMEPAGE="http://willem.engen.nl/projects/disper/"
SRC_URI="http://ppa.launchpad.net/disper-dev/ppa/ubuntu/pool/main/d/disper/${PN}_${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-lang/python"
RDEPEND="${DEPEND}"

S="${WORKDIR}/dispercur"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed."
	doman "${PN}.1"
	dodoc README
}
