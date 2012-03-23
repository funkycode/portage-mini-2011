# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.*"

inherit distutils

MY_PN="web.py"

DESCRIPTION="A small and simple web framework for Python"
HOMEPAGE="http://www.webpy.org http://pypi.python.org/pypi/web.py"
SRC_URI="http://www.webpy.org/static/${MY_PN}-${PV}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/web.py-${PV}"

PYTHON_MODULES="web"

src_test() {
	testing() {
		local exit_status="0" test tests="db http net template utils"
		for test in ${tests}; do
			python_execute "$(PYTHON)" web/${test}.py || exit_status="$?"
		done

		return "${exit_status}"
	}
	python_execute_function testing
}
