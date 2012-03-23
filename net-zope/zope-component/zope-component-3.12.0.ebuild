# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.* *-jython *-pypy-*"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Zope Component Architecture"
HOMEPAGE="http://pypi.python.org/pypi/zope.component"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="$(python_abi_depend net-zope/namespaces-zope[zope])
	$(python_abi_depend net-zope/zodb)
	$(python_abi_depend net-zope/zope-configuration)
	$(python_abi_depend net-zope/zope-event)
	$(python_abi_depend net-zope/zope-hookable)
	$(python_abi_depend net-zope/zope-i18nmessageid)
	$(python_abi_depend ">=net-zope/zope-interface-3.8.0")
	$(python_abi_depend net-zope/zope-proxy)
	$(python_abi_depend net-zope/zope-schema)"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)"
PDEPEND="$(python_abi_depend net-zope/zope-security)"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODULES="${PN/-//}"
