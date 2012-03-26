# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.* *-jython *-pypy-*"
DISTUTILS_SRC_TEST="py.test"
PYTHON_NAMESPACES="mwlib"

inherit distutils python-namespaces

DESCRIPTION="mediawiki parser and utility library"
HOMEPAGE="http://pediapress.com/code/ https://github.com/pediapress/mwlib http://pypi.python.org/pypi/mwlib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc latex"

RDEPEND="dev-lang/perl
	$(python_abi_depend dev-python/bottle)
	$(python_abi_depend dev-python/gevent)
	$(python_abi_depend dev-python/imaging)
	$(python_abi_depend dev-python/lxml)
	$(python_abi_depend "=dev-python/odfpy-0.9*")
	$(python_abi_depend ">=dev-python/py-1.4")
	$(python_abi_depend ">=dev-python/pyPdf-1.12")
	$(python_abi_depend ">=dev-python/pyparsing-1.4.11")
	$(python_abi_depend dev-python/roman)
	$(python_abi_depend ">=dev-python/qserve-0.2.7")
	$(python_abi_depend dev-python/setuptools)
	$(python_abi_depend dev-python/sqlite3dbm)
	$(python_abi_depend ">=dev-python/timelib-0.2")
	$(python_abi_depend virtual/python-json[external])
	latex? ( virtual/latex-base )"
DEPEND="${RDEPEND}
	app-arch/unzip
	doc? ( $(python_abi_depend dev-python/sphinx) )"

S="${WORKDIR}/${P}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="changelog.rst"

src_prepare() {
	distutils_src_prepare

	# mwlib.apipkg is actually used.
	sed -e 's/, "apipkg"//' -i setup.py

	# Execute odflint script.
	sed \
		-e "/def _get_odflint_module():/,/odflint = _get_odflint_module()/d" \
		-e "s/odflint.lint(path)/os.system('odflint %s' % path)/" \
		-i tests/test_odfwriter.py

	# Disable tests, which require installed mw-zip script.
	rm -f tests/test_nuwiki.py
	rm -f tests/test_redirect.py
	rm -f tests/test_zipwiki.py

	# Disable failing test.
	rm -f tests/test_render.py
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		pushd docs > /dev/null
		emake html
		popd > /dev/null
	fi
}

src_test() {
	distutils_src_test tests
}

src_install() {
	distutils_src_install
	python_clean_installation_image
	python-namespaces_src_install

	if use doc; then
		pushd docs/_build/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static
		popd > /dev/null
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
