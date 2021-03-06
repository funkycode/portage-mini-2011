# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Martian is a library that allows the embedding of configuration information in Python code."
HOMEPAGE="http://pypi.python.org/pypi/martian"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="$(python_abi_depend net-zope/zope-interface)"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)
	test? ( $(python_abi_depend net-zope/zope-testing) )"

DOCS="CHANGES.txt CREDITS.txt src/martian/README.txt"

src_install() {
	distutils_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/martian/tests"
	}
	python_execute_function -q delete_tests
}
