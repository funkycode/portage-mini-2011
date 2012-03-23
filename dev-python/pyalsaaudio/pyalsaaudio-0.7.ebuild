# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="*-jython"

inherit distutils

DESCRIPTION="ALSA bindings"
HOMEPAGE="http://www.sourceforge.net/projects/pyalsaaudio http://pypi.python.org/pypi/pyalsaaudio"
SRC_URI="mirror://sourceforge/pyalsaaudio/${P}.tar.gz mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

DEPEND="media-libs/alsa-lib"
RDEPEND="${DEPEND}"
RESTRICT="test"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="CHANGES README"

src_test() {
	testing() {
		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" test.py -v
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		pushd doc/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static
		popd > /dev/null
	fi

	insinto /usr/share/doc/${PF}/examples
	doins *test.py
}
