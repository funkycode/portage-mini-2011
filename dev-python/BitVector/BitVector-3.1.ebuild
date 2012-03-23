# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5"

inherit distutils

DESCRIPTION="A pure-Python memory-efficient packed representation for bit arrays"
HOMEPAGE="https://engineering.purdue.edu/kak/dist/ http://pypi.python.org/pypi/BitVector"
SRC_URI="https://engineering.purdue.edu/kak/dist/${P}.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

PYTHON_MODULES="BitVector.py"

src_prepare() {
	distutils_src_prepare

	# Don't install test.py.
	rm -f test.py
}

src_test() {
	cd Test${PN}

	testing() {
		python_execute PYTHONPATH="../build-${PYTHON_ABI}/lib" "$(PYTHON)" Test.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	dohtml ${P}.html
}
