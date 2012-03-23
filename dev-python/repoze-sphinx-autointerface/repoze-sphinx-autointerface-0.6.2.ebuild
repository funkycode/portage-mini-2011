# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.*"

inherit distutils

MY_PN="${PN//-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Sphinx extension: auto-generates API docs from Zope interfaces"
HOMEPAGE="http://pypi.python.org/pypi/repoze.sphinx.autointerface"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="repoze"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="$(python_abi_depend dev-python/namespaces-repoze[repoze,repoze.sphinx])
	$(python_abi_depend dev-python/sphinx)
	$(python_abi_depend net-zope/zope-interface)"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt TODO.txt"
PYTHON_MODULES="${PN//-//}.py"
