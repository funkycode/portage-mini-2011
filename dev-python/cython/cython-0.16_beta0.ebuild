# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="*-jython *-pypy-*"

inherit distutils

MY_PN="Cython"
MY_P="${MY_PN}-${PV/_/.}"

DESCRIPTION="The Cython compiler for writing C extensions for the Python language"
HOMEPAGE="http://www.cython.org/ http://pypi.python.org/pypi/Cython"
SRC_URI="http://www.cython.org/release/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="doc examples numpy"

DEPEND="numpy? ( $(python_abi_depend dev-python/numpy) )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="README.txt ToDo.txt USAGE.txt"
PYTHON_MODULES="Cython cython.py pyximport"

src_test() {
	testing() {
		python_execute "$(PYTHON)" runtests.py -vv --work-dir tests-${PYTHON_ABI}
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		# "-A c" is for ignoring of "Doc/primes.c".
		dohtml -A c -r Doc/*
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r Demos/*
	fi
}
