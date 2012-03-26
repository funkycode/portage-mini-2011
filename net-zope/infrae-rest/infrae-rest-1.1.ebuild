# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.* *-jython *-pypy-*"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="infrae.rest allows to define a REST API to access and manage Silva content"
HOMEPAGE="http://pypi.python.org/pypi/infrae.rest"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="$(python_abi_depend net-zope/namespaces-silva[infrae])
	$(python_abi_depend dev-python/martian)
	$(python_abi_depend net-zope/five-grok)
	$(python_abi_depend net-zope/grokcore-view)
	$(python_abi_depend net-zope/zope-browser)
	$(python_abi_depend net-zope/zope-component)
	$(python_abi_depend net-zope/zope-event)
	$(python_abi_depend net-zope/zope-interface)
	$(python_abi_depend net-zope/zope-location)
	$(python_abi_depend net-zope/zope-publisher)
	$(python_abi_depend net-zope/zope-traversing)"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)"

S="${WORKDIR}/${MY_P}"

DOCS="docs/HISTORY.txt README.txt"
PYTHON_MODULES="${PN/-//}"
