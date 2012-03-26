# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.* *-jython *-pypy-*"

inherit distutils

DESCRIPTION="Python Bindings for TagLib"
HOMEPAGE="http://mathema.tician.de//software/tagpy http://pypi.python.org/pypi/tagpy"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 sparc x86"
IUSE="examples"

RDEPEND="$(python_abi_depend ">=dev-libs/boost-1.48[python]")
	>=media-libs/taglib-1.4"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)"

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

src_prepare() {
	# Disable broken check for Distribute.
	sed -e "s/if 'distribute' not in setuptools.__file__:/if False:/" -i aksetup_helper.py

	distutils_src_prepare
}

src_configure() {
	configuration() {
		python_execute "$(PYTHON)" configure.py \
			--taglib-inc-dir="${EPREFIX}/usr/include/taglib" \
			--boost-python-libname="boost_python-${PYTHON_ABI}-mt"
	}
	python_execute_function -s configuration
}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins test/*
	fi
}
