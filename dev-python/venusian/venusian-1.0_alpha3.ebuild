# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_P="${PN}-${PV/_alpha/a}"

DESCRIPTION="A library for deferring decorator actions"
HOMEPAGE="http://pypi.python.org/pypi/venusian"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_P}.tar.gz"

LICENSE="repoze"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="$(python_abi_depend dev-python/setuptools)
	doc? ( $(python_abi_depend dev-python/sphinx) )"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"

src_prepare() {
	distutils_src_prepare

	# Fix Sphinx theme.
	sed \
		-e "/# Add and use Pylons theme/,+32d" \
		-e "/html_theme_options =/,+2d" \
		-i docs/conf.py || die "sed failed"
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		pushd docs > /dev/null
		mkdir _themes
		emake html
		popd > /dev/null
	fi
}

src_install() {
	distutils_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/venusian/tests"
	}
	python_execute_function -q delete_tests

	if use doc; then
		pushd docs/_build/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static
		popd > /dev/null
	fi
}
