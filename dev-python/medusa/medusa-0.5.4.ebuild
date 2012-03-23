# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.*"

inherit distutils

DESCRIPTION="A framework for writing long-running, high-performance network servers in Python, using asynchronous sockets"
HOMEPAGE="http://www.amk.ca/python/code/medusa.html http://pypi.python.org/pypi/medusa"
SRC_URI="http://www.amk.ca/files/python/${P}.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DOCS="CHANGES.txt docs/*.txt"

src_install() {
	distutils_src_install

	dohtml docs/*.html docs/*.gif
	insinto /usr/share/doc/${PF}/examples
	doins -r demo/*
}
