# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="zope.interface extension for defining data schemas"
HOMEPAGE="http://pypi.python.org/pypi/zope.schema"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="test"

RDEPEND="$(python_abi_depend net-zope/namespaces-zope[zope])
	$(python_abi_depend dev-python/six)
	$(python_abi_depend net-zope/zope-event)
	$(python_abi_depend ">=net-zope/zope-interface-3.6.0")
	$(python_abi_depend net-zope/zope-i18nmessageid)"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)
	test? ( $(python_abi_depend net-zope/zope-testing) )"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODULES="${PN/-//}"
