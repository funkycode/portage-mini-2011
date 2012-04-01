# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="*-jython *-pypy-*"

inherit distutils eutils

MY_PN="${PN}2"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="PostgreSQL database adapter for Python"
HOMEPAGE="http://initd.org/psycopg/ http://pypi.python.org/pypi/psycopg2"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="debug doc examples mxdatetime"

RDEPEND=">=dev-db/postgresql-base-8.1
	mxdatetime? ( $(python_abi_depend -e "3.* *-pypy-*" dev-python/egenix-mx-base) )"
DEPEND="${RDEPEND}
	doc? (
		=dev-lang/python-2*
		$(python_abi_depend dev-python/sphinx)
	)"
RESTRICT="test"

S="${WORKDIR}/${MY_P}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="AUTHORS doc/HACKING doc/SUCCESS"
PYTHON_MODULES="${PN}2"

src_prepare() {
	epatch "${FILESDIR}/${PN}-2.0.9-round-solaris.patch"
	epatch "${FILESDIR}/${PN}-2.4.2-setup.py.patch"

	# http://psycopg.lighthouseapp.com/projects/62710/tickets/107
	python_convert_shebangs 2 doc/src/tools/stitch_text.py

	if use debug; then
		sed -i "s/^\(define=\)/\1PSYCOPG_DEBUG,/" setup.cfg || die "sed failed"
	fi

	if use mxdatetime; then
		sed -i "s/\(use_pydatetime=\)1/\10/" setup.cfg || die "sed failed"
	fi
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		pushd doc > /dev/null
		emake -j1 html text
		popd > /dev/null
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dodoc doc/psycopg2.txt

		pushd doc/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static
		popd > /dev/null
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/*
	fi
}
