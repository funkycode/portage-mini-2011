# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_DEPEND="<<[xml]>>"
PYTHON_MULTIPLE_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="Markdown"
MY_P=${MY_PN}-${PV}

DESCRIPTION="Python implementation of Markdown."
HOMEPAGE="http://www.freewisdom.org/projects/python-markdown http://pypi.python.org/pypi/Markdown"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86 ~ppc-macos ~x86-macos"
IUSE="doc pygments"

DEPEND=""
RDEPEND="pygments? ( $(python_abi_depend dev-python/pygments) )"

S="${WORKDIR}/${MY_P}"

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

src_prepare() {
	distutils_src_prepare

	prepare_tests() {
		if [[ "$(python_get_version -l --major)" == "3" ]]; then
			2to3-${PYTHON_ABI} -nw --no-diffs tests
		fi
	}
	python_execute_function -s prepare_tests
}

src_test() {
	python_execute_nosetests -P 'build/lib' -s -- -P -w tests
}

src_install() {
	distutils_src_install

	if use doc; then
		install_documentation() {
			dodoc -r build/docs/*
		}
		python_execute_function -f -q -s install_documentation
	fi
}
