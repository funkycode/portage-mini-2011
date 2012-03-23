# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_DEPEND="<<[ncurses]>>"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="*-jython"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="3.1"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="Urwid is a curses-based user interface library for Python"
HOMEPAGE="http://excess.org/urwid/ http://pypi.python.org/pypi/urwid"
SRC_URI="http://excess.org/urwid/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="examples"

DEPEND="$(python_abi_depend dev-python/setuptools)"
RDEPEND=""

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

src_install() {
	distutils_src_install

	dohtml reference.html tutorial.html

	if use examples; then
		docinto examples
		dodoc bigtext.py browse.py calc.py dialog.py edit.py fib.py graph.py input_test.py tour.py
	fi
}
