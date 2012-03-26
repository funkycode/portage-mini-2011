# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="Tool for transforming reStructuredText to PDF using ReportLab"
HOMEPAGE="http://code.google.com/p/rst2pdf/ http://pypi.python.org/pypi/rst2pdf"
SRC_URI="http://rst2pdf.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="$(python_abi_depend dev-python/docutils)
	$(python_abi_depend dev-python/imaging)
	$(python_abi_depend dev-python/pygments)
	$(python_abi_depend ">=dev-python/reportlab-2.4")"
RDEPEND="${DEPEND}"

DOCS="Contributors.txt CHANGES.txt README.txt doc/*"

pkg_postinst() {
	distutils_pkg_postinst

	elog "rst2pdf can work with the following packages for additional functionality:"
	elog "   dev-python/sphinx       - versatile documentation creation"
	elog "   dev-python/pythonmagick - image processing with ImageMagick"
	elog "   dev-python/matplotlib   - mathematical formulae"
	elog "   media-gfx/uniconvertor  - vector image format conversion"
	elog "It can also use wordaxe for hyphenation, but this package is not"
	elog "available in the portage tree yet. Please refer to the manual"
	elog "installed in /usr/share/doc/${PF}/ for more information."
}
