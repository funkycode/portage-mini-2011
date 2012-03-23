# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.1 *-jython"

inherit distutils eutils

DESCRIPTION="Scalable, non-blocking web server and tools"
HOMEPAGE="http://www.tornadoweb.org/ http://pypi.python.org/pypi/tornado"
SRC_URI="http://github.com/downloads/facebook/tornado/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="curl"

RDEPEND="curl? ( $(python_abi_depend -i "2.*" dev-python/pycurl) )
	$(python_abi_depend virtual/python-json)"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-python-3.2.3.patch"
}

src_test() {
	testing() {
		python_execute "$(PYTHON)" setup.py build -b build-${PYTHON_ABI} install --root="${T}/tests-${PYTHON_ABI}" || die "Installation for tests failed with $(python_get_implementation_and_version)"
		pushd "${T}/tests-${PYTHON_ABI}${EPREFIX}$(python_get_sitedir)" > /dev/null
		python_execute PYTHONPATH="." "$(PYTHON)" tornado/test/runtests.py || return
		popd > /dev/null
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/tornado/test"
	}
	python_execute_function -q delete_tests
}
