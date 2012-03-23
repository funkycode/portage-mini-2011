# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="Manuel lets you build tested documentation."
HOMEPAGE="http://packages.python.org/manuel/ http://pypi.python.org/pypi/manuel"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="test"

DEPEND="$(python_abi_depend dev-python/setuptools)
	test? ( $(python_abi_depend net-zope/zope-testing) )"
RDEPEND=""

DOCS="CHANGES.txt"
