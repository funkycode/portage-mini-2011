# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="PDF generator using HTML and CSS"
HOMEPAGE="http://www.xhtml2pdf.com/ http://pypi.python.org/pypi/xhtml2pdf"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="$(python_abi_depend dev-python/html5lib)
	$(python_abi_depend dev-python/imaging)
	$(python_abi_depend dev-python/pyPdf)
	$(python_abi_depend dev-python/reportlab)
	$(python_abi_depend dev-python/setuptools)"
RDEPEND="${DEPEND}"
