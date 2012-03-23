# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="Library to access any version control system"
HOMEPAGE="http://pypi.python.org/pypi/anyvc"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bazaar doc git mercurial subversion"

RDEPEND="$(python_abi_depend dev-python/apipkg)
	$(python_abi_depend dev-python/execnet)
	$(python_abi_depend dev-python/py)
	bazaar? ( $(python_abi_depend -e "2.5 *-pypy-*" dev-vcs/bzr) )
	git? ( $(python_abi_depend dev-python/dulwich) )
	mercurial? ( $(python_abi_depend dev-vcs/mercurial) )
	subversion? ( $(python_abi_depend dev-python/subvertpy) )"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)
	doc? ( $(python_abi_depend dev-python/sphinx) )"

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		sphinx-build -b html docs docs_output || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		pushd docs_output > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static
		popd > /dev/null
	fi
}
