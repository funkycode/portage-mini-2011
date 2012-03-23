# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.*"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="*-jython"
DISTUTILS_SRC_TEST="py.test"

inherit distutils

DESCRIPTION="Flexible static resources for web applications."
HOMEPAGE="http://fanstatic.org https://bitbucket.org/fanstatic/fanstatic http://pypi.python.org/pypi/fanstatic"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="$(python_abi_depend dev-python/paste)
	$(python_abi_depend dev-python/webob)"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)"

DOCS="CHANGES.txt CREDITS.txt README.txt"

src_prepare() {
	distutils_src_prepare

	# https://bitbucket.org/fanstatic/fanstatic/issue/71
	sed -e "s/test_serf(/_&/" -i fanstatic/test_wsgi.py
}

src_test() {
	python_execute_py.test -e -P 'build-${PYTHON_ABI}/lib' 'build-${PYTHON_ABI}/lib'
}

src_install() {
	distutils_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/fanstatic/"{conftest.py,test_*.py,testdata}
	}
	python_execute_function -q delete_tests
}
