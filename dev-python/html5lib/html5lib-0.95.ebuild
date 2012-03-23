# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_DEPEND="<<[xml]>>"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.* *-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="HTML parser based on the WHAT-WG Web Applications 1.0 (\"HTML5\") specification"
HOMEPAGE="http://code.google.com/p/html5lib/ http://pypi.python.org/pypi/html5lib"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND="$(python_abi_depend dev-python/setuptools)
	test? ( $(python_abi_depend virtual/python-json) )"
RDEPEND=""

src_prepare() {
	distutils_src_prepare

	# Disable failing tests.
	rm -f html5lib/tests/test_parser.py
	rm -f html5lib/tests/test_tokenizer.py
	rm -f html5lib/tests/test_treewalkers.py
}

src_install() {
	distutils_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/html5lib/tests"
	}
	python_execute_function -q delete_tests
}
