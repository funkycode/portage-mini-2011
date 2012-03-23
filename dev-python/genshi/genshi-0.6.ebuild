# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.* *-jython"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_P="Genshi-${PV}"

DESCRIPTION="A toolkit for generation of output for the web"
HOMEPAGE="http://genshi.edgewall.org/ http://pypi.python.org/pypi/Genshi"
SRC_URI="ftp://ftp.edgewall.com/pub/genshi/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE="doc examples"

DEPEND="$(python_abi_depend dev-python/setuptools)"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_install() {
	distutils_src_install

	if use doc; then
		dodoc doc/*.txt
		dohtml -r doc/*
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
