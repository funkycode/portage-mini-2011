# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.*"

inherit distutils

DESCRIPTION="Python library to create spreadsheet files compatible with Excel"
HOMEPAGE="http://pypi.python.org/pypi/xlwt"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="examples"

DEPEND=""
RDEPEND=""

src_prepare() {
	distutils_src_prepare

	# Don't install documentation and examples in site-packages directories.
	sed -e "/package_data/,+6d" -i setup.py || die "sed failed"
}

src_install() {
	distutils_src_install

	insinto /usr/share/doc/${PF}
	doins -r xlwt/doc/xlwt.html
	if use examples; then
		doins -r xlwt/examples
	fi
}
