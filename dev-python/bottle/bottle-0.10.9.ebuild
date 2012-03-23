# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_TESTS_RESTRICTED_ABIS="*-jython"

inherit distutils

DESCRIPTION="Fast and simple WSGI-framework for small web-applications."
HOMEPAGE="http://bottlepy.org/ https://github.com/defnull/bottle http://pypi.python.org/pypi/bottle"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="$(python_abi_depend virtual/python-json)"
RDEPEND="${DEPEND}"

PYTHON_MODULES="bottle.py"

src_prepare() {
	distutils_src_prepare
	sed -e "/^sys.path.insert/d" -i test/{servertest.py,testall.py}

	prepare_tests() {
		cp -r test test-${PYTHON_ABI}

		if [[ "$(python_get_version -l --major)" == "3" ]]; then
			2to3-${PYTHON_ABI} -nw --no-diffs test-${PYTHON_ABI}
		fi
	}
	python_execute_function prepare_tests
}

src_test() {
	testing() {
		python_execute PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test-${PYTHON_ABI}/testall.py
	}
	python_execute_function testing
}
