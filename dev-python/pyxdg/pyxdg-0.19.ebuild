# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_DEPEND="<<[xml]>>"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.*"

inherit distutils eutils

DESCRIPTION="A Python module to deal with freedesktop.org specifications"
HOMEPAGE="http://freedesktop.org/wiki/Software/pyxdg http://people.freedesktop.org/~lanius/"
SRC_URI="http://people.freedesktop.org/~lanius/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

DOCS="AUTHORS"
PYTHON_MODULES="xdg"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${PN}-subprocess.patch"
}

src_install () {
	distutils_src_install

	insinto /usr/share/doc/${PF}/tests
	insopts -m 755
	doins test/*
}
