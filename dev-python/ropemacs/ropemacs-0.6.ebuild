# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.* *-jython"

inherit distutils eutils

DESCRIPTION="Rope in Emacs"
HOMEPAGE="http://rope.sourceforge.net/ropemacs.html http://pypi.python.org/pypi/ropemacs"
SRC_URI="http://bitbucket.org/agr/ropemacs/get/8b277a188d00.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="$(python_abi_depend dev-python/rope)
	$(python_abi_depend dev-python/ropemode)"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

DOCS="docs/*.txt"

src_prepare() {
	distutils_src_prepare

	# Patch for nonexistent ropemode in setup.py
	epatch "${FILESDIR}/${P}-ropemode-dir.patch"
}

pkg_postinst() {
	distutils_pkg_postinst

	elog "In order to enable ropemacs support in Emacs, install"
	elog "app-emacs/pymacs and add the following line to your ~/.emacs file:"
	elog "  (pymacs-load \"ropemacs\" \"rope-\")"
}
