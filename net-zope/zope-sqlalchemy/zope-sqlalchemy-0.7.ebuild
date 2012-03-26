# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Minimal Zope/SQLAlchemy transaction integration"
HOMEPAGE="http://pypi.python.org/pypi/zope.sqlalchemy"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="$(python_abi_depend net-zope/namespaces-zope[zope])
	$(python_abi_depend ">=dev-python/sqlalchemy-0.5.1")
	$(python_abi_depend net-zope/transaction)
	$(python_abi_depend net-zope/zope-interface)"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt CREDITS.txt src/zope/sqlalchemy/README.txt"
PYTHON_MODULES="${PN/-//}"
