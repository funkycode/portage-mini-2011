# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="*-jython"

inherit distutils eutils

DESCRIPTION="DNS toolkit for Python"
HOMEPAGE="http://www.dnspython.org/ http://pypi.python.org/pypi/dnspython http://pypi.python.org/pypi/dnspython3"
SRC_URI="http://www.dnspython.org/kits/${PV}/${P}.tar.gz http://www.dnspython.org/kits3/${PV}/${PN}3-${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-solaris"
IUSE="examples pycrypto"

DEPEND="pycrypto? ( $(python_abi_depend -e "*-jython *-pypy-*" dev-python/pycrypto) )"
RDEPEND="${DEPEND}"

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"
DOCS="ChangeLog README"
PYTHON_MODULES="dns"

src_prepare() {
	pushd "${WORKDIR}/${PN}3-${PV}" > /dev/null
	epatch "${FILESDIR}/${P}-python-3.patch"
	popd > /dev/null

	preparation() {
		if [[ "$(python_get_version -l --major)" == "2" ]]; then
			cp -r "${WORKDIR}/${P}" "${WORKDIR}/${P}-${PYTHON_ABI}"
		else
			cp -r "${WORKDIR}/${PN}3-${PV}" "${WORKDIR}/${P}-${PYTHON_ABI}"
		fi
	}
	python_execute_function preparation
}

src_test() {
	testing() {
		cd tests

		local exit_status="0" test
		for test in *.py; do
			if ! python_execute PYTHONPATH="../build/lib" "$(PYTHON)" "${test}"; then
				eerror "${test} failed with $(python_get_implementation_and_version)"
				exit_status="1"
			fi
		done

		return "${exit_status}"
	}
	python_execute_function -s testing
}

src_install() {
	distutils_src_install

	if use examples; then
		install_examples() {
			insinto /usr/share/doc/${PF}/examples/python$(python_get_version -l --major)
			doins examples/*
		}
		python_execute_function -q -s install_examples
	fi
}
