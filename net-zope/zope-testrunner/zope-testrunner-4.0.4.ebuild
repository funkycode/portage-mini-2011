# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Zope testrunner script."
HOMEPAGE="http://pypi.python.org/pypi/zope.testrunner"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc sparc x86"
IUSE="examples"

RDEPEND="$(python_abi_depend net-zope/namespaces-zope[zope])
	$(python_abi_depend net-zope/zope-exceptions)
	$(python_abi_depend net-zope/zope-interface)
	!<net-zope/zope-testing-3.10.0"
DEPEND="${RDEPEND}
	app-arch/unzip
	$(python_abi_depend dev-python/setuptools)
	$(python_abi_depend -i "3.*" net-zope/zope-fixers)"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODULES="${PN/-//}"

src_install() {
	distutils_src_install

	delete_examples() {
		rm -fr "${ED}$(python_get_sitedir)/zope/testrunner/testrunner-ex"*
	}
	python_execute_function -q delete_examples

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r src/zope/testrunner/testrunner-ex{,-pp-lib,-pp-products}
	fi
}
