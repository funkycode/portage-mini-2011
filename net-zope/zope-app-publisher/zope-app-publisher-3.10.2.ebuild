# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.* *-jython *-pypy-*"

inherit distutils

MY_PN="${PN//-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Implementations and means for configuration of Zope 3-style views and resources."
HOMEPAGE="http://pypi.python.org/pypi/zope.app.publisher"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="$(python_abi_depend net-zope/namespaces-zope[zope,zope.app])
	$(python_abi_depend net-zope/zope-browsermenu)
	$(python_abi_depend net-zope/zope-browserpage)
	$(python_abi_depend net-zope/zope-browserresource)
	$(python_abi_depend net-zope/zope-component)
	$(python_abi_depend net-zope/zope-configuration)
	$(python_abi_depend net-zope/zope-componentvocabulary)
	$(python_abi_depend net-zope/zope-datetime)
	$(python_abi_depend net-zope/zope-i18nmessageid)
	$(python_abi_depend net-zope/zope-interface)
	$(python_abi_depend net-zope/zope-location)
	$(python_abi_depend net-zope/zope-ptresource)
	$(python_abi_depend ">=net-zope/zope-publisher-3.12")
	$(python_abi_depend net-zope/zope-schema)
	$(python_abi_depend net-zope/zope-security)"
DEPEND="${RDEPEND}
	app-arch/unzip
	$(python_abi_depend dev-python/setuptools)"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODULES="${PN//-//}"
