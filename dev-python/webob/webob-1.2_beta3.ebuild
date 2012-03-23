# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.1"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="WebOb"
MY_P="${MY_PN}-${PV/_beta/b}"

DESCRIPTION="WSGI request and response object"
HOMEPAGE="http://webob.org/ http://pypi.python.org/pypi/WebOb"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="doc"

DEPEND="app-arch/unzip
	$(python_abi_depend dev-python/setuptools)
	doc? ( $(python_abi_depend dev-python/sphinx) )"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		"$(PYTHON -f)" setup.py build_sphinx || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		pushd build/sphinx/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static
		popd > /dev/null
	fi
}
