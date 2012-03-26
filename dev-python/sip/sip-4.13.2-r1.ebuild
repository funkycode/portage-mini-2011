# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="*-jython *-pypy-*"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"

inherit eutils python toolchain-funcs

DESCRIPTION="Python extension module generator for C and C++ libraries"
HOMEPAGE="http://www.riverbankcomputing.co.uk/software/sip/intro http://pypi.python.org/pypi/SIP"
SRC_URI="http://www.riverbankcomputing.com/static/Downloads/${PN}${PV%%.*}/${P}.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 sip )"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="debug doc"

DEPEND=""
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}/${PN}-4.9.3-darwin.patch"
	sed -e "s/ -O2//g" -i specs/* || die "sed failed"
	python_src_prepare
}

src_configure() {
	configuration() {
		local myconf=("$(PYTHON)"
			configure.py
			--bindir="${EPREFIX}/usr/bin"
			--incdir="${EPREFIX}$(python_get_includedir)"
			--destdir="${EPREFIX}$(python_get_sitedir)"
			--sipdir="${EPREFIX}/usr/share/sip"
			$(use debug && echo --debug)
			CC="$(tc-getCC)"
			CXX="$(tc-getCXX)"
			LINK="$(tc-getCXX)"
			LINK_SHLIB="$(tc-getCXX)"
			CFLAGS="${CFLAGS}"
			CXXFLAGS="${CXXFLAGS}"
			LFLAGS="${LDFLAGS}"
			STRIP=":")
		python_execute "${myconf[@]}"
	}
	python_execute_function -s configuration
}

src_install() {
	python_src_install

	dodoc NEWS

	if use doc; then
		dohtml -r doc/html/*
	fi
}

pkg_postinst() {
	python_mod_optimize sipconfig.py sipdistutils.py

	ewarn "When updating dev-python/sip, you usually need to rebuild packages, which depend on it,"
	ewarn "such as dev-python/PyQt4, dev-python/qscintilla-python and kde-base/pykde4. If you have app-portage/gentoolkit"
	ewarn "installed, you can find these packages with \`equery d dev-python/sip dev-python/PyQt4\`."
}

pkg_postrm() {
	python_mod_cleanup sipconfig.py sipdistutils.py
}
