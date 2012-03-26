# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.*"

inherit distutils

MY_PN="${PN/-/.}"
MY_P=${MY_PN}-${PV}

DESCRIPTION="System for managing development buildouts"
HOMEPAGE="http://pypi.python.org/pypi/zc.buildout"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="$(python_abi_depend net-zope/namespaces-zc[zc])
	$(python_abi_depend dev-python/setuptools)"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${MY_P}

DOCS="CHANGES.txt todo.txt"
PYTHON_MODULES="${PN/-//}"

src_install() {
	distutils_src_install

	# Delete README.txt installed in incorrect location.
	rm -f "${ED}usr/README.txt"
}
