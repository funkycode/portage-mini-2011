# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.*"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="*-jython"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="Werkzeug"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Collection of various utilities for WSGI applications"
HOMEPAGE="http://werkzeug.pocoo.org/ http://pypi.python.org/pypi/Werkzeug"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="redis test"

RDEPEND="$(python_abi_depend virtual/python-json[external])
	redis? ( $(python_abi_depend dev-python/redis-py) )"
DEPEND="$(python_abi_depend dev-python/setuptools)
	test? ( $(python_abi_depend -e "*-jython *-pypy-*" dev-python/lxml) )"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES"

src_prepare() {
	distutils_src_prepare

	# Disable redis-related tests.
	# https://github.com/mitsuhiko/werkzeug/issues/120
	sed -e "s/import redis/redis = None/" -i werkzeug/testsuite/contrib/cache.py
}

src_install() {
	distutils_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/werkzeug/testsuite"
	}
	python_execute_function -q delete_tests
}
