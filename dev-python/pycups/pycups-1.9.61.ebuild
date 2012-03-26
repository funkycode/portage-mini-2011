# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.* *-jython"

inherit distutils flag-o-matic

DESCRIPTION="Python bindings for the CUPS API"
HOMEPAGE="http://cyberelk.net/tim/software/pycups/ http://pypi.python.org/pypi/pycups"
SRC_URI="http://cyberelk.net/tim/data/pycups/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh sparc x86"
IUSE="doc examples"

RDEPEND="net-print/cups"
DEPEND="${RDEPEND}
	doc? ( dev-python/epydoc )"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

src_compile() {
	append-cflags -DVERSION=\\\"${PV}\\\"
	distutils_src_compile

	if use doc; then
		emake doc
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r html/
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples/
	fi
}
