# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="RDFLib is a Python library for working with RDF, a simple yet powerful language for representing information."
HOMEPAGE="http://www.rdflib.net/ http://pypi.python.org/pypi/rdflib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 ~x86-linux"
IUSE="berkdb examples mysql redland sqlite zodb"

RDEPEND="$(python_abi_depend dev-python/isodate)
	berkdb? ( $(python_abi_depend -e "*-jython" dev-python/bsddb3) )
	mysql? ( $(python_abi_depend -e "3.* *-jython" dev-python/mysql-python) )
	redland? ( $(python_abi_depend -e "3.* *-jython *-pypy-*" dev-libs/redland-bindings[python]) )
	sqlite? ( $(python_abi_depend -e "*-jython" virtual/python-sqlite) )
	zodb? ( $(python_abi_depend -e "2.5 3.* *-jython *-pypy-*" net-zope/zodb) )"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)"

DOCS="CHANGELOG"

src_test() {
	python_execute_nosetests -e -P '$(ls -d build-${PYTHON_ABI}/lib)' -- -P -w '$([[ "$(python_get_version -l --major)" == "3" ]] && echo build/src || echo .)'
}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/*
	fi
}
