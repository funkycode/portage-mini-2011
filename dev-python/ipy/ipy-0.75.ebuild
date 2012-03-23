# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"

inherit distutils

MY_PN="IPy"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Class and tools for handling of IPv4 and IPv6 addresses and networks"
HOMEPAGE="https://github.com/haypo/python-ipy/wiki http://pypi.python.org/pypi/IPy"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

DOCS="ChangeLog README"
PYTHON_MODULES="IPy.py"

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test/test_IPy.py
	}
	python_execute_function testing
}
