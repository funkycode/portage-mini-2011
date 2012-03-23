# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.* *-jython *-pypy-*"
# DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="Fabric"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Fabric is a simple, Pythonic tool for remote execution and deployment."
HOMEPAGE="http://fabfile.org http://pypi.python.org/pypi/Fabric"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="$(python_abi_depend dev-python/pycrypto)
	$(python_abi_depend dev-python/ssh)"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)"
#	test? ( $(python_abi_depend dev-python/fudge) )

# Tests broken.
RESTRICT="test"

S="${WORKDIR}/${MY_P}"

PYTHON_MODULES="fabfile fabric"

src_test() {
	distutils_src_test --with-doctest
}
