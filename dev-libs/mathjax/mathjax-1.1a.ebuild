# Copyright owners: Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

DESCRIPTION="MathJax - JavaScript display engine for LaTeX and MathML"
HOMEPAGE="http://www.mathjax.org/ https://github.com/mathjax"
SRC_URI="https://github.com/mathjax/MathJax/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="doc"

DEPEND=""
RDEPEND=""
RESTRICT="test"

src_unpack() {
	unpack ${A}
	mv mathjax-MathJax-* ${P}
}

src_install() {
	insinto /usr/share/mathjax
	doins -r MathJax.js config extensions fonts jax unpacked
	dodoc -r README.md test

	if use doc; then
		pushd docs/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [A-Za-z]* _images _static
		popd > /dev/null
	fi
}
