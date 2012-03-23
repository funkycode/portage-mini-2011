# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 *-jython"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="Another form generation library"
HOMEPAGE="http://docs.repoze.org/deform http://pypi.python.org/pypi/deform"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="repoze"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND="$(python_abi_depend ">=dev-python/chameleon-1.2.3")
	$(python_abi_depend ">=dev-python/colander-0.8")
	$(python_abi_depend ">=dev-python/peppercorn-0.3")
	$(python_abi_depend dev-python/translationstring)"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)
	doc? ( $(python_abi_depend dev-python/sphinx) )
	test? ( $(python_abi_depend dev-python/beautifulsoup:4) )"

DOCS="CHANGES.txt README.txt TODO.txt"

src_prepare() {
	distutils_src_prepare

	# Fix Sphinx theme.
	sed \
		-e "/# Add and use Pylons theme/,+29d" \
		-e "s/html_theme = 'pylons'/html_theme = 'default'/" \
		-e "/html_theme_options =/d" \
		-i docs/conf.py || die "sed failed"
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

src_install() {
	distutils_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/deform/tests"
	}
	python_execute_function -q delete_tests

	if use doc; then
		pushd docs/_build/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static
		popd > /dev/null
	fi
}
