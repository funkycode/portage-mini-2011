# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.* *-jython *-pypy-*"

inherit distutils

MY_PN="${PN//-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Zope app setup helper"
HOMEPAGE="http://pypi.python.org/pypi/zope.app.appsetup"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="$(python_abi_depend net-zope/namespaces-zope[zope,zope.app])
	$(python_abi_depend net-zope/zodb)
	$(python_abi_depend net-zope/zope-app-publication)
	$(python_abi_depend net-zope/zope-component)
	$(python_abi_depend net-zope/zope-configuration)
	$(python_abi_depend net-zope/zope-container)
	$(python_abi_depend net-zope/zope-error)
	$(python_abi_depend net-zope/zope-event)
	$(python_abi_depend net-zope/zope-interface)
	$(python_abi_depend net-zope/zope-lifecycleevent)
	$(python_abi_depend net-zope/zope-processlifetime)
	$(python_abi_depend net-zope/zope-security)
	$(python_abi_depend net-zope/zope-session)
	$(python_abi_depend net-zope/zope-site)
	$(python_abi_depend net-zope/zope-traversing)"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODULES="${PN//-//}"
