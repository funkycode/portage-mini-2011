# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.*"

inherit distutils

MY_PN="${PN//-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="ZC Buildout recipe for creating test runners"
HOMEPAGE="http://pypi.python.org/pypi/zc.recipe.testrunner"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="$(python_abi_depend net-zope/namespaces-zc[zc,zc.recipe])
	$(python_abi_depend dev-python/setuptools)
	$(python_abi_depend net-zope/z3c-recipe-scripts)
	$(python_abi_depend ">=net-zope/zc-buildout-1.5.0")
	$(python_abi_depend net-zope/zope-testrunner)"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt src/zc/recipe/testrunner/*.txt"
PYTHON_MODULES="${PN//-//}"
