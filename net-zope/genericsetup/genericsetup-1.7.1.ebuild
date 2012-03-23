# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.* *-jython *-pypy-*"

inherit distutils

MY_PN="Products.GenericSetup"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Read Zope configuration state from profile dirs / tarballs"
HOMEPAGE="http://pypi.python.org/pypi/Products.GenericSetup"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="$(python_abi_depend net-zope/namespaces-zope[Products])
	$(python_abi_depend dev-python/setuptools)
	$(python_abi_depend net-zope/accesscontrol)
	$(python_abi_depend net-zope/acquisition)
	$(python_abi_depend net-zope/datetime)
	$(python_abi_depend net-zope/five-localsitemanager)
	$(python_abi_depend net-zope/mailhost)
	$(python_abi_depend net-zope/pythonscripts)
	$(python_abi_depend net-zope/zcatalog)
	$(python_abi_depend net-zope/zctextindex)
	$(python_abi_depend net-zope/zexceptions)
	$(python_abi_depend net-zope/zodb)
	$(python_abi_depend ">=net-zope/zope-2.12.3")
	$(python_abi_depend net-zope/zope-component)
	$(python_abi_depend net-zope/zope-configuration)
	$(python_abi_depend net-zope/zope-event)
	$(python_abi_depend net-zope/zope-formlib)
	$(python_abi_depend net-zope/zope-interface)
	$(python_abi_depend net-zope/zope-location)
	$(python_abi_depend net-zope/zope-schema)
	$(python_abi_depend net-zope/zope-testing)"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/sphinx)"

S="${WORKDIR}/${MY_P}"

DOCS="README.txt docs/CHANGES.rst"
PYTHON_MODULES="${MY_PN/.//}"

src_prepare() {
	distutils_src_prepare

	# Don't require eggtestinfo.
	sed -e "s/'eggtestinfo',//" -i setup.py
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		"$(PYTHON -f)" setup.py build_sphinx || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		pushd build/sphinx/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static
		popd > /dev/null
	fi
}
