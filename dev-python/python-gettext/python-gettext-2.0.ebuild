# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.1"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Python Gettext po to mo file compiler."
HOMEPAGE="http://pypi.python.org/pypi/python-gettext"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

DEPEND="app-arch/unzip
	$(python_abi_depend dev-python/setuptools)
	test? ( $(python_abi_depend -i "2.*" dev-python/unittest2) )"
RDEPEND=""

DOCS="CHANGES.txt"
PYTHON_MODULES="pythongettext"

src_install() {
	distutils_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/pythongettext/tests"
	}
	python_execute_function -q delete_tests
}
