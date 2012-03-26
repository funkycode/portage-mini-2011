# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.1 *-jython"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="The Pyramid web application development framework, a Pylons project"
HOMEPAGE="http://pypi.python.org/pypi/pyramid"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD repoze ZPL doc? ( CCPL-Attribution-ShareAlike-NonCommercial-3.0 )"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc test"

RDEPEND="$(python_abi_depend dev-python/chameleon)
	$(python_abi_depend dev-python/mako)
	$(python_abi_depend dev-python/pastedeploy)
	$(python_abi_depend dev-python/repoze-lru)
	$(python_abi_depend dev-python/setuptools)
	$(python_abi_depend dev-python/translationstring)
	$(python_abi_depend dev-python/venusian)
	$(python_abi_depend dev-python/webob)
	$(python_abi_depend net-zope/zope-deprecation)
	$(python_abi_depend net-zope/zope-interface)"
DEPEND="${RDEPEND}
	doc? (
		dev-python/docutils[python_abis_2.7]
		dev-python/repoze-sphinx-autointerface[python_abis_2.7]
		dev-python/sphinx[python_abis_2.7]
	)
	test? (
		$(python_abi_depend dev-python/virtualenv)
		$(python_abi_depend dev-python/webtest)
		$(python_abi_depend -i "2.*-cpython" net-zope/zope-component)
	)"

DOCS="BFG_HISTORY.txt CHANGES.txt HISTORY.txt README.rst TODO.txt"

src_prepare() {
	distutils_src_prepare

	# Fix Sphinx theme.
	sed -e "/# Add and use Pylons theme/,+36d" -i docs/conf.py || die "sed failed"
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		python_execute "$(PYTHON 2.7)" setup.py build_sphinx || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/pyramid/tests"
	}
	python_execute_function -q delete_tests

	if use doc; then
		pushd build/sphinx/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _images _static
		popd > /dev/null
	fi
}
