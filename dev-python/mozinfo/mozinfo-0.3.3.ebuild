# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.*"

inherit distutils

DESCRIPTION="file for interface to transform introspected system information to a format pallatable to Mozilla"
HOMEPAGE="http://pypi.python.org/pypi/mozinfo"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="$(python_abi_depend dev-python/setuptools)
	$(python_abi_depend virtual/python-json)"
RDEPEND="${DEPEND}"

PYTHON_MODULES="mozinfo.py"
