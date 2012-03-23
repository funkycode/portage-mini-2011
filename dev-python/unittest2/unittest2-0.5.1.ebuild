# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"

inherit distutils

DESCRIPTION="The new features in unittest for Python 2.7 backported to Python 2.4+."
HOMEPAGE="http://pypi.python.org/pypi/unittest2 http://pypi.python.org/pypi/unittest2py3k http://code.google.com/p/unittest-ext/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
	mirror://pypi/${PN:0:1}/${PN}py3k/${PN}py3k-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

DEPEND="$(python_abi_depend dev-python/setuptools)"
RDEPEND="${DEPEND}"

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

DOCS="README.txt"

src_prepare() {
	preparation() {
		if [[ "${PYTHON_ABI}" == 3.* ]]; then
			cp -pr "${WORKDIR}/${PN}py3k-${PV}" "${S}-${PYTHON_ABI}" || return 1
		else
			cp -pr "${S}" "${S}-${PYTHON_ABI}" || return 1
		fi

		# Disable versioning of unit2 script to avoid collision with versioning performed by python_merge_intermediate_installation_images().
		sed -e "/'%s = unittest2:main_' % SCRIPT2,/d" -i "${S}-${PYTHON_ABI}/setup.py" || return 1
	}
	python_execute_function -q preparation
}

src_test() {
	testing() {
		./unit2 discover
	}
	python_execute_function -s testing
}
