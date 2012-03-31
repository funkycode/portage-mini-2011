# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.*"
PYTHON_TESTS_RESTRICTED_ABIS="*-jython *-pypy-*"
DISTUTILS_SRC_TEST="py.test"

inherit distutils

DESCRIPTION="Sphinx integration with different issuetrackers"
HOMEPAGE="http://packages.python.org/sphinxcontrib-issuetracker/ http://pypi.python.org/pypi/sphinxcontrib-issuetracker"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND="$(python_abi_depend dev-python/namespaces-sphinxcontrib)
	$(python_abi_depend ">=dev-python/sphinx-1.0")"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)
	test? ( 
		$(python_abi_depend -e "${PYTHON_TESTS_RESTRICTED_ABIS}" dev-python/mock)
		$(python_abi_depend -e "${PYTHON_TESTS_RESTRICTED_ABIS}" dev-python/pyquery)
	)"

PYTHON_MODULES="${PN/-//}.py"

src_prepare() {
	distutils_src_prepare

	# Tests from tests/test_stylesheet.py require dev-python/PyQt4[X,webkit] and virtualx.eclass.
	rm -f tests/test_stylesheet.py
}
