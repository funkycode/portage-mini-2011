# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.*"

inherit distutils

MY_PN="MiniMock"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="The simplest possible mock library"
HOMEPAGE="http://pypi.python.org/pypi/MiniMock"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="$(python_abi_depend dev-python/setuptools)"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

DOCS="docs/changelog.rst docs/index.rst"
PYTHON_MODULES="minimock.py"
