# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"

inherit distutils

DESCRIPTION="A collection of protocols modules written in ASN.1 language."
HOMEPAGE="http://pyasn1.sourceforge.net/ http://pypi.python.org/pypi/pyasn1-modules"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="$(python_abi_depend ">=dev-python/pyasn1-0.1.1")"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)"

DOCS="CHANGES README"
PYTHON_MODULES="pyasn1_modules"

src_install() {
	distutils_src_install

	insinto /usr/share/doc/${PF}/tools
	doins tools/*
}
