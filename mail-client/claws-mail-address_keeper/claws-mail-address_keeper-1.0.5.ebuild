# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/claws-mail-address_keeper/claws-mail-address_keeper-1.0.5.ebuild,v 1.3 2012/04/07 11:26:37 maekke Exp $

inherit eutils

MY_P="${P#claws-mail-}"

DESCRIPTION="Plugin for Claws to collect all recipients in an address book folder"
HOMEPAGE="http://www.claws-mail.org/"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RDEPEND=">=mail-client/claws-mail-3.8.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README

	# kill useless files
	rm -f "${D}"/usr/lib*/claws-mail/plugins/*.{a,la}
}
