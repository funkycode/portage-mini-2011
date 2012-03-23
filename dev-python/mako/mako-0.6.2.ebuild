# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="*-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_P="Mako-${PV}"

DESCRIPTION="A Python templating language"
HOMEPAGE="http://www.makotemplates.org/ http://pypi.python.org/pypi/Mako"
SRC_URI="http://www.makotemplates.org/downloads/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="doc"

RDEPEND="$(python_abi_depend ">=dev-python/beaker-1.1")
	$(python_abi_depend ">=dev-python/markupsafe-0.9.2")"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)"

S="${WORKDIR}/${MY_P}"

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

src_prepare() {
	distutils_src_prepare

	preparation() {
		if [[ "$(python_get_version -l --major)" == "3" ]]; then
			2to3-${PYTHON_ABI} -nw --no-diffs test
		fi
	}
	python_execute_function -s preparation
}

src_test() {
	distutils_src_test -P -w test
}

src_install() {
	distutils_src_install

	if use doc; then
		pushd doc > /dev/null
		rm -fr build
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static
		popd > /dev/null
	fi
}
