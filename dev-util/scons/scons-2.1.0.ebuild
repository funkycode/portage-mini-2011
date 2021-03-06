# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_DEPEND="<<[{*-cpython *-jython}threads]>>"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.*"

inherit distutils eutils

DESCRIPTION="Extensible Python-based build utility"
HOMEPAGE="http://www.scons.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	doc? (
		http://www.scons.org/doc/${PV}/HTML/${PN}-user.html -> ${P}-user.html
		http://www.scons.org/doc/${PV}/PDF/${PN}-user.pdf -> ${P}-user.pdf
	)"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="doc"

DEPEND=""
RDEPEND=""

DOCS="CHANGES.txt RELEASE.txt"
PYTHON_MODULES="SCons"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/scons-1.2.0-popen.patch"
	epatch "${FILESDIR}/${P}-jython.patch"

	sed -e "s|/usr/local/bin:/opt/bin:/bin:/usr/bin|${EPREFIX}/usr/local/bin:${EPREFIX}/opt/bin:${EPREFIX}/bin:${EPREFIX}/usr/bin:/usr/local/bin:/opt/bin:/bin:/usr/bin|g" -i engine/SCons/Platform/posix.py || die "sed failed"
	sed -e "s/sys.platform\[:6\] == 'darwin'/False/" -i setup.py || die "sed failed"
}

src_install () {
	distutils_src_install \
		--install-data "${EPREFIX}/usr/share" \
		--no-version-script \
		--standard-lib

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins "${DISTDIR}/${P}-user."{html,pdf}
	fi
}
