# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/ldapfuse/ldapfuse-1.0.ebuild,v 1.1 2011/12/14 23:10:46 radhermit Exp $

EAPI="4"

DESCRIPTION="A virtual filesystem for FUSE which allows navigation of an LDAP tree"
HOMEPAGE="http://sourceforge.net/projects/ldapfuse/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-nds/openldap
	sys-fs/fuse
	>=sys-libs/libhx-3.12"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	dev-util/pkgconfig"

DOCS=( doc/changelog.txt doc/rfcs.txt )
