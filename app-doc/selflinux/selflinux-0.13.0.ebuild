# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/selflinux/selflinux-0.13.0.ebuild,v 1.3 2011/12/18 19:47:46 phajdan.jr Exp $

MY_P="SelfLinux-${PV}"

DESCRIPTION="german-language hypertext tutorial about Linux"
HOMEPAGE="http://selflinux.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}-html.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_install() {
	dohtml * -r
}
