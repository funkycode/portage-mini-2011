# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.* *-jython *-pypy-*"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Five bridges and patches to use Chameleon with Zope 2."
HOMEPAGE="http://pypi.python.org/pypi/five.pt"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="$(python_abi_depend net-zope/namespaces-zope[five])
	$(python_abi_depend dev-python/restrictedpython)
	$(python_abi_depend dev-python/sourcecodegen)
	$(python_abi_depend net-zope/accesscontrol)
	$(python_abi_depend net-zope/acquisition)
	$(python_abi_depend ">=net-zope/z3c-pt-2.2")
	$(python_abi_depend net-zope/zexceptions)
	$(python_abi_depend net-zope/zope)
	$(python_abi_depend net-zope/zope-component)
	$(python_abi_depend net-zope/zope-contentprovider)
	$(python_abi_depend ">=net-zope/zope-pagetemplate-3.6.2")
	$(python_abi_depend net-zope/zope-proxy)
	$(python_abi_depend net-zope/zope-tal)
	$(python_abi_depend net-zope/zope-traversing)"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)"

S="${WORKDIR}/${MY_P}"

DOCS="AUTHOR.txt CHANGES.txt README.txt"
PYTHON_MODULES="${PN/-//}"
