# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_TESTS_RESTRICTED_ABIS="*-jython"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="*"

inherit distutils eutils

DESCRIPTION="Parse RSS and Atom feeds in Python"
HOMEPAGE="http://code.google.com/p/feedparser/ http://pypi.python.org/pypi/feedparser"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

# sgmllib is licensed under PSF-2.
LICENSE="BSD-2 PSF-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

DEPEND="$(python_abi_depend dev-python/setuptools)"
RDEPEND=""

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"
DOCS="NEWS"

src_prepare() {
	mv feedparser/sgmllib3.py feedparser/_feedparser_sgmllib.py || die "Renaming sgmllib3.py failed"
	epatch "${FILESDIR}/${P}-sgmllib.patch"

	sed -e "/import feedparser/isys.path.insert(0, '../build/lib')" -i feedparser/feedparsertest.py

	distutils_src_prepare

	preparation() {
		if [[ "$(python_get_version -l --major)" == "3" ]]; then
			2to3-${PYTHON_ABI} -nw --no-diffs feedparser/feedparsertest.py
		fi
	}
	python_execute_function -s preparation
}

src_test() {
	testing() {
		cd feedparser || return 1
		python_execute "$(PYTHON)" feedparsertest.py
	}
	python_execute_function -s testing
}

pkg_postinst() {
	python_mod_optimize -A "2.*" feedparser.py
	python_mod_optimize -A "3.*" feedparser.py _feedparser_sgmllib.py
}

pkg_postrm() {
	python_mod_cleanup -A "2.*" feedparser.py
	python_mod_cleanup -A "3.*" feedparser.py _feedparser_sgmllib.py
}
