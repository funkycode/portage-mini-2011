# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.* *-jython *-pypy-*"

inherit distutils eutils

DESCRIPTION="Scientific PYthon Development EnviRonment"
HOMEPAGE="http://code.google.com/p/spyderlib/ http://pypi.python.org/pypi/spyder"
SRC_URI="http://spyderlib.googlecode.com/files/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc ipython matplotlib numpy pep8 +pyflakes pylint +rope scipy sphinx"

RDEPEND="$(python_abi_depend ">=dev-python/PyQt4-4.4[webkit]")
	ipython? ( $(python_abi_depend -e "2.5" dev-python/ipython) )
	matplotlib? ( $(python_abi_depend -e "2.5" dev-python/matplotlib) )
	numpy? ( $(python_abi_depend dev-python/numpy) )
	pep8? ( $(python_abi_depend dev-python/pep8) )
	pyflakes? ( $(python_abi_depend ">=dev-python/pyflakes-0.3") )
	pylint? ( $(python_abi_depend dev-python/pylint) )
	rope? ( $(python_abi_depend ">=dev-python/rope-0.9.3") )
	scipy? ( $(python_abi_depend sci-libs/scipy) )
	sphinx? ( $(python_abi_depend dev-python/sphinx) )"
DEPEND="${RDEPEND}
	doc? ( $(python_abi_depend dev-python/sphinx) )"

PYTHON_MODULES="spyderlib spyderplugins"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${PN}-2.1.2-disable_sphinx_dependency.patch"
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		python_execute PYTHONPATH="build-$(PYTHON -f --ABI)/lib" sphinx-build doc doc_output || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils_src_install

	doicon spyderlib/images/spyder.svg
	make_desktop_entry spyder Spyder spyder "Development;IDE"

	if use doc; then
		pushd doc_output > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _images _static
		popd > /dev/null
	fi
}
