# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.* *-jython *-pypy-*"

inherit distutils

MY_PN="TTFQuery"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Font metadata and glyph outline extraction utility library"
HOMEPAGE="http://ttfquery.sourceforge.net/ https://launchpad.net/ttfquery http://pypi.python.org/pypi/TTFQuery"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""

RDEPEND="$(python_abi_depend dev-python/fonttools)
	$(python_abi_depend dev-python/numpy)"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)"

S="${WORKDIR}/${MY_P}"
