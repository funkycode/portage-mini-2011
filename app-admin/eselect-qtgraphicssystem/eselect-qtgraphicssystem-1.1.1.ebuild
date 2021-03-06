# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-qtgraphicssystem/eselect-qtgraphicssystem-1.1.1.ebuild,v 1.1 2012/02/05 12:58:19 wired Exp $

EAPI=4

DESCRIPTION="Utility to change the active Qt Graphics System"
HOMEPAGE="https://gitorious.org/gentoo-qt/eselect-qtgraphicssystem"
SRC_URI="http://dev.gentoo.org/~wired/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 -sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND=">=app-admin/eselect-1.2.4"

src_install() {
	insinto "/usr/share/eselect/modules"
	doins qtgraphicssystem.eselect
}
