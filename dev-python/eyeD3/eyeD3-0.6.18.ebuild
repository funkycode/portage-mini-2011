# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.*"

inherit distutils

DESCRIPTION="Module for manipulating ID3 (v1 + v2) tags in Python"
HOMEPAGE="http://eyed3.nicfit.net/"
SRC_URI="http://eyed3.nicfit.net/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND=""

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_configure() {
	python_execute_function -d -f -q
}

src_install() {
	dohtml *.html && rm -f *.html
	distutils_src_install

	install_script() {
		mkdir -p "${T}/images/${PYTHON_ABI}${EPREFIX}/usr/bin"
		cp bin/eyeD3 "${T}/images/${PYTHON_ABI}${EPREFIX}/usr/bin"
	}
	python_execute_function -q install_script
	python_merge_intermediate_installation_images "${T}/images"

	doman doc/*.1
}
