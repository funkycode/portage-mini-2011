# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.*"

inherit distutils

DESCRIPTION="Platform-independent file locking module"
HOMEPAGE="http://code.google.com/p/pylockfile/ http://pypi.python.org/pypi/lockfile http://smontanaro.dyndns.org/python/"
SRC_URI="http://pylockfile.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

DEPEND="doc? ( $(python_abi_depend dev-python/sphinx) )"
RDEPEND=""

DOCS="ACKS README RELEASE-NOTES"

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		pushd doc > /dev/null
		emake html
		popd > /dev/null
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		pushd doc/.build/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static
		popd > /dev/null
	fi
}
