# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.*"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="*-jython"

inherit distutils

DESCRIPTION="Platform for Python test doubles: mocks, stubs, fakes, and dummies"
HOMEPAGE="http://labix.org/mocker http://pypi.python.org/pypi/mocker"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

DEPEND="$(python_abi_depend dev-python/setuptools)"
RDEPEND=""

PYTHON_MODULES="mocker.py"

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test.py
	}
	python_execute_function testing
}
