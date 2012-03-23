# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.*"

inherit distutils

MY_PN="FormEncode"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="HTML form validation, generation, and conversion package"
HOMEPAGE="http://formencode.org/ http://pypi.python.org/pypi/FormEncode"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

DEPEND="$(python_abi_depend dev-python/setuptools)"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

DOCS="docs/*.txt"
