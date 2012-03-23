# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils eutils

DESCRIPTION="Create Python ebuilds for Gentoo by querying The Python Package Index"
HOMEPAGE="http://code.google.com/p/g-pypi/"
SRC_URI="http://dev.gentoo.org/~neurogeek/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-portage/gentoolkit
	$(python_abi_depend dev-python/cheetah)
	$(python_abi_depend dev-python/configobj)
	$(python_abi_depend dev-python/pygments)
	$(python_abi_depend dev-python/setuptools)
	dev-python/yolk"
RDEPEND="${DEPEND}"

src_prepare(){
	distutils_src_prepare
	epatch "${FILESDIR}/${P}_setup.patch"
}
