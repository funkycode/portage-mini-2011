# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.1"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="*-jython *-pypy-*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="WebTest"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Helper to test WSGI applications"
HOMEPAGE="http://webtest.pythonpaste.org/ http://pypi.python.org/pypi/WebTest"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

RDEPEND="$(python_abi_depend -e "*-jython *-pypy-*" dev-python/pyquery)
	$(python_abi_depend dev-python/webob)
	$(python_abi_depend virtual/python-json)"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)
	doc? ( $(python_abi_depend dev-python/sphinx) )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	distutils_src_prepare

	# https://bitbucket.org/ianb/webtest/issue/24
	# https://bitbucket.org/ianb/webtest/raw/c0faae620b78/docs/index_fixt.py
	cat << EOF > docs/index_fixt.py
# -*- coding: utf-8 -*-
from doctest import ELLIPSIS

def setup_test(test):
    for example in test.examples:
        example.options.setdefault(ELLIPSIS, 1)
setup_test.__test__ = False

EOF
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		python_execute sphinx-build docs html || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils_src_install

	delete_version-specific_modules() {
		if [[ "$(python_get_version -l --major)" == "3" ]]; then
			rm -f "${ED}$(python_get_sitedir)/webtest/lint.py"
		else
			rm -f "${ED}$(python_get_sitedir)/webtest/lint3.py"
		fi
	}
	python_execute_function -q delete_version-specific_modules

	if use doc; then
		pushd html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static
		popd > /dev/null
	fi
}
