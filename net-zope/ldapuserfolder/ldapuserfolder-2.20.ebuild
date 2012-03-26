# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.* *-jython *-pypy-*"

inherit distutils

MY_PN="Products.LDAPUserFolder"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A LDAP-enabled Zope 2 user folder"
HOMEPAGE="http://pypi.python.org/pypi/Products.LDAPUserFolder"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

RDEPEND="$(python_abi_depend net-zope/namespaces-zope[Products])
	$(python_abi_depend ">=dev-python/python-ldap-2.0.6")
	$(python_abi_depend net-zope/accesscontrol)
	$(python_abi_depend net-zope/acquisition)
	$(python_abi_depend net-zope/cmfdefault)
	$(python_abi_depend net-zope/genericsetup)
	$(python_abi_depend net-zope/datetime)
	$(python_abi_depend net-zope/persistence)
	$(python_abi_depend net-zope/zodb)
	$(python_abi_depend net-zope/zope)
	$(python_abi_depend net-zope/zope-component)
	$(python_abi_depend net-zope/zope-interface)"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)"

S="${WORKDIR}/${MY_P}"

DOCS="Products/LDAPUserFolder/CHANGES.txt Products/LDAPUserFolder/HISTORY.txt Products/LDAPUserFolder/README.ActiveDirectory.txt Products/LDAPUserFolder/README.txt Products/LDAPUserFolder/SAMPLE_RECORDS.txt"
PYTHON_MODULES="${MY_PN/.//}"

pkg_postinst() {
	python_mod_optimize -x /skins/ ${MY_PN/.//}
}
