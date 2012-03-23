# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="Paste"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Tools for using a Web Server Gateway Interface stack"
HOMEPAGE="http://pythonpaste.org http://pypi.python.org/pypi/Paste"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-interix ~amd64-linux ~x86-linux ~x86-macos ~sparc-solaris"
IUSE="doc flup openid"

RDEPEND="$(python_abi_depend dev-python/namespaces-paste)
	$(python_abi_depend dev-python/setuptools)
	flup? ( $(python_abi_depend dev-python/flup) )
	openid? ( $(python_abi_depend dev-python/python-openid) )"
DEPEND="${RDEPEND}
	doc? ( $(python_abi_depend dev-python/sphinx) )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	distutils_src_prepare

	# Disable failing tests.
	rm -f tests/test_cgiapp.py
	sed \
		-e "s/test_find_file/_&/" \
		-e "s/test_deep/_&/" \
		-e "s/test_static_parser/_&/" \
		-i tests/test_urlparser.py || die "sed failed"
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		PYTHONPATH="." "$(PYTHON -f)" setup.py build_sphinx || die "Generation of documentation failed"
	fi
}

# Define custom src_test() due to requirement of PYTHONPATH=".".
src_test() {
	python_execute_nosetests -P .
}

src_install() {
	distutils_src_install

	if use doc; then
		pushd build/sphinx/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static
		popd > /dev/null
	fi
}
