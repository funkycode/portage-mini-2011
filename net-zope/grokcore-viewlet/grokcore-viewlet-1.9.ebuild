# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.* *-jython *-pypy-*"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Grok-like configuration for zope viewlets"
HOMEPAGE="http://grok.zope.org/ http://pypi.python.org/pypi/grokcore.viewlet"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="$(python_abi_depend net-zope/namespaces-grok)
	$(python_abi_depend ">=dev-python/martian-0.13")
	$(python_abi_depend ">=net-zope/grokcore-component-2.1")
	$(python_abi_depend ">=net-zope/grokcore-security-1.5")
	$(python_abi_depend ">=net-zope/grokcore-view-2.2")
	$(python_abi_depend net-zope/zope-browserpage)
	$(python_abi_depend net-zope/zope-component)
	$(python_abi_depend net-zope/zope-contentprovider)
	$(python_abi_depend net-zope/zope-interface)
	$(python_abi_depend net-zope/zope-publisher)
	$(python_abi_depend net-zope/zope-security)
	$(python_abi_depend net-zope/zope-viewlet)"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODULES="${PN/-//}"
