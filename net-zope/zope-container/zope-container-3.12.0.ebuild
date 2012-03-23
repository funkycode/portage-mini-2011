# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.* *-jython *-pypy-*"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Zope Container"
HOMEPAGE="http://pypi.python.org/pypi/zope.container"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="$(python_abi_depend net-zope/namespaces-zope[zope])
	$(python_abi_depend net-zope/zodb)
	$(python_abi_depend net-zope/zope-app-dependable)
	$(python_abi_depend net-zope/zope-broken)
	$(python_abi_depend net-zope/zope-component)
	$(python_abi_depend net-zope/zope-dottedname)
	$(python_abi_depend net-zope/zope-event)
	$(python_abi_depend net-zope/zope-filerepresentation)
	$(python_abi_depend net-zope/zope-i18nmessageid)
	$(python_abi_depend net-zope/zope-interface)
	$(python_abi_depend net-zope/zope-lifecycleevent)
	$(python_abi_depend net-zope/zope-location)
	$(python_abi_depend net-zope/zope-publisher)
	$(python_abi_depend net-zope/zope-schema)
	$(python_abi_depend net-zope/zope-security)
	$(python_abi_depend net-zope/zope-size)
	$(python_abi_depend net-zope/zope-traversing)"
DEPEND="${RDEPEND}
	app-arch/unzip
	$(python_abi_depend dev-python/setuptools)"

S="${WORKDIR}/${MY_P}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="CHANGES.txt README.txt"
PYTHON_MODULES="${PN/-//}"

src_install() {
	distutils_src_install
	python_clean_installation_image
}
