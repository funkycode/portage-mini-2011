# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="handling of Mozilla XUL app profiles"
HOMEPAGE="http://pypi.python.org/pypi/mozprofile"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="$(python_abi_depend dev-python/manifestdestiny)
	$(python_abi_depend dev-python/setuptools)
	$(python_abi_depend virtual/python-json[external])
	$(python_abi_depend virtual/python-sqlite)"
RDEPEND="${DEPEND}"
