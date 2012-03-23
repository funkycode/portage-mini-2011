# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_DEPEND="<<[{*-cpython}tk?]>>"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_TESTS_RESTRICTED_ABIS="3.*"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="*-jython"

inherit distutils

DESCRIPTION="Python code static checker"
HOMEPAGE="http://www.logilab.org/projects/pylint/ http://pypi.python.org/pypi/pylint"
SRC_URI="ftp://ftp.logilab.org/pub/${PN}/${P}.tar.gz mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="examples tk"

# Versions specified in __pkginfo__.py.
RDEPEND="$(python_abi_depend ">=dev-python/logilab-common-0.53.0")
	$(python_abi_depend ">=dev-python/astng-0.21.1")"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)"

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"
DOCS="doc/*.txt"

src_test() {
	testing() {
		python_execute PYTHONPATH="build/lib" pytest -v
	}
	python_execute_function -s testing
}

src_install() {
	distutils_src_install

	if ! use tk; then
		rm -f "${ED}usr/bin/pylint-gui"*
	fi

	doman man/{pylint,pyreverse}.1

	if use examples; then
		docinto examples
		dodoc examples/*
	fi

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/pylint/test"
	}
	python_execute_function -q delete_tests
}
