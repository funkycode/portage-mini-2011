# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="*-jython *-pypy-*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Reads FITS images and tables into numpy or numarray objects and manipulates FITS headers"
HOMEPAGE="http://www.stsci.edu/resources/software_hardware/pyfits http://pypi.python.org/pypi/pyfits"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="$(python_abi_depend dev-python/numpy)"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/d2to1)
	$(python_abi_depend dev-python/stsci-distutils)"

src_test() {
	python_execute_nosetests -e -P '$(ls -d build-${PYTHON_ABI}/lib.*)' -- -P '$(ls -d build-${PYTHON_ABI}/lib.*)'
}

src_install() {
	distutils_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/pyfits/tests"
	}
	python_execute_function -q delete_tests
}
