# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.* *-jython"

inherit distutils eutils

DESCRIPTION="Python refactoring library"
HOMEPAGE="http://rope.sourceforge.net/ http://pypi.python.org/pypi/rope"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="$(python_abi_depend dev-python/setuptools)"
RDEPEND=""

DOCS="docs/*.txt"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-fix_tests_results.patch"
	epatch "${FILESDIR}/${P}-python-2.7.patch"
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib:." "$(PYTHON)" ropetest/__init__.py
	}
	python_execute_function testing
}
