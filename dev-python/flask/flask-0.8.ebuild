# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.*"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="*-jython"
# Usage of flaskext namespace is deprecated since Flask 0.8.
PYTHON_NAMESPACES="flaskext"

inherit distutils python-namespaces

MY_PN="Flask"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A microframework based on Werkzeug, Jinja2 and good intentions"
HOMEPAGE="http://pypi.python.org/pypi/Flask"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

RDEPEND="$(python_abi_depend dev-python/blinker)
	$(python_abi_depend ">=dev-python/jinja-2.4")
	$(python_abi_depend ">=dev-python/werkzeug-0.6.1")"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)
	doc? ( $(python_abi_depend dev-python/sphinx) )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	distutils_src_prepare

	# https://github.com/mitsuhiko/flask/commit/0dd9dc37b6618b8091c2a0f849f5f3143dc6eafc
	sed -e "s/\(from .sessions import\).*/\1 SecureCookieSession, NullSession/" -i flask/session.py
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		pushd docs > /dev/null
		PYTHONPATH=".." emake html
		popd > /dev/null
	fi
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" run-tests.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	python-namespaces_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/flask/testsuite"
	}
	python_execute_function -q delete_tests

	if use doc; then
		pushd docs/_build/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _images _static
		popd > /dev/null
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}

pkg_postinst() {
	distutils_pkg_postinst
	python-namespaces_pkg_postinst
}

pkg_postrm() {
	distutils_pkg_postrm
	python-namespaces_pkg_postrm
}
