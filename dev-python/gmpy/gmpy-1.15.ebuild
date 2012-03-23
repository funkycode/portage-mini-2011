# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="*-jython *-pypy-*"

inherit distutils

DESCRIPTION="Python bindings for GMP library"
HOMEPAGE="http://code.google.com/p/gmpy/ http://pypi.python.org/pypi/gmpy"
SRC_URI="http://${PN}.googlecode.com/files/${P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86 ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND="dev-libs/gmp"
DEPEND="${RDEPEND}
	app-arch/unzip"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="doc/gmpydoc.txt"

src_test() {
	testing() {
		if [[ "$(python_get_version -l --major)" == "3" ]]; then
			pushd test3 > /dev/null
		else
			pushd test > /dev/null
		fi
		python_execute PYTHONPATH="$(ls -d ../build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" gmpy_test.py || return
		popd > /dev/null
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	dohtml doc/index.html
}
