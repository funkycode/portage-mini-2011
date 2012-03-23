# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="MarkupSafe"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Implements a XML/HTML/XHTML Markup safe string for Python"
HOMEPAGE="http://pypi.python.org/pypi/MarkupSafe"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris"
IUSE=""

DEPEND="$(python_abi_depend dev-python/setuptools)"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

DISTUTILS_GLOBAL_OPTIONS=("*-cpython --with-speedups")

src_install() {
	distutils_src_install
	python_clean_installation_image

	delete_tests() {
		rm -f "${ED}$(python_get_sitedir)/markupsafe/tests.py"
	}
	python_execute_function -q delete_tests
}
