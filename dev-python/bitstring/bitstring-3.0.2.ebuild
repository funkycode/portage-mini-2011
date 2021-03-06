# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Simple construction, analysis and modification of binary data."
HOMEPAGE="http://code.google.com/p/python-bitstring/ http://pypi.python.org/pypi/bitstring"
SRC_URI="http://python-bitstring.googlecode.com/files/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

DOCS="README.txt release_notes.txt"
PYTHON_MODULES="bitstring.py"

src_test() {
	distutils_src_test -w test
}
