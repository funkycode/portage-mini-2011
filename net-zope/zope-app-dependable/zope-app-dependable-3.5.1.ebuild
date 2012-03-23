# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.* *-jython *-pypy-*"

inherit distutils

MY_PN="${PN//-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Simple Dependency API"
HOMEPAGE="http://pypi.python.org/pypi/zope.app.dependable"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="$(python_abi_depend net-zope/namespaces-zope[zope,zope.app])
	$(python_abi_depend net-zope/zope-annotation)
	$(python_abi_depend net-zope/zope-exceptions)
	$(python_abi_depend net-zope/zope-i18nmessageid)
	$(python_abi_depend net-zope/zope-interface)
	$(python_abi_depend net-zope/zope-lifecycleevent)
	$(python_abi_depend net-zope/zope-location)
	$(python_abi_depend net-zope/zope-traversing)"
DEPEND="${RDEPEND}
	app-arch/unzip
	$(python_abi_depend dev-python/setuptools)"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODULES="${PN//-//}"
