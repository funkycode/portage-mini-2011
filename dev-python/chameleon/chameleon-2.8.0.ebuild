# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="*-jython"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="Chameleon"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Fast HTML/XML Template Compiler."
HOMEPAGE="http://chameleon.repoze.org/ http://pypi.python.org/pypi/Chameleon https://github.com/malthe/chameleon"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="repoze"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND="$(python_abi_depend -i "2.5 2.6" dev-python/ordereddict)
	$(python_abi_depend dev-python/setuptools)"
DEPEND="${RDEPEND}
	doc? ( $(python_abi_depend dev-python/sphinx) )
	test? ( $(python_abi_depend -i "2.5 2.6" dev-python/unittest2) )"

S="${WORKDIR}/${MY_P}"

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		PYTHONPATH="src" emake html
	fi
}

src_install() {
	distutils_src_install

	delete_tests_and_incompatible_modules() {
		rm -fr "${ED}$(python_get_sitedir)/chameleon/tests"

		if [[ "$(python_get_version -l --major)" == "3" ]]; then
			rm -f "${ED}$(python_get_sitedir)/chameleon/"{benchmark.py,py25.py}
		fi
	}
	python_execute_function -q delete_tests_and_incompatible_modules

	if use doc; then
		pushd _build/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static
		popd > /dev/null
	fi
}
