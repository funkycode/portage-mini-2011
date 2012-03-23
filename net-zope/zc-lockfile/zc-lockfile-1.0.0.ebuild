# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
# Future versions of net-zope/zope-testing will support Python 3.
PYTHON_TESTS_RESTRICTED_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="${PN/-/.}"
MY_P=${MY_PN}-${PV}

DESCRIPTION="Basic inter-process locks"
HOMEPAGE="http://pypi.python.org/pypi/zc.lockfile"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="test"

RDEPEND="$(python_abi_depend net-zope/namespaces-zc[zc])"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)
	test? ( $(python_abi_depend -e "3.*" net-zope/zope-testing) )"

S="${WORKDIR}"/${MY_P}

DOCS="doc.txt src/zc/lockfile/CHANGES.txt src/zc/lockfile/README.txt"
PYTHON_MODULES="${PN/-//}"

src_install() {
	distutils_src_install

	delete_tests() {
		rm -f "${ED}"$(python_get_sitedir)/zc/lockfile/tests.py
	}
	python_execute_function -q delete_tests
}
