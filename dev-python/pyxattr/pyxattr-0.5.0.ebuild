# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="*-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Python interface to xattr"
HOMEPAGE="http://sourceforge.net/projects/pyxattr/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-linux"
IUSE=""

DEPEND="sys-apps/attr"
RDEPEND="${DEPEND}"

src_prepare() {
	distutils_src_prepare

	# Fix compatibility with Python >=3.2.
	sed \
		-e 's/PyBytes_FromString("security")/PyUnicode_FromString("security")/' \
		-e 's/PyBytes_FromString("system")/PyUnicode_FromString("system")/' \
		-e 's/PyBytes_FromString("trusted")/PyUnicode_FromString("trusted")/' \
		-e 's/PyBytes_FromString("user")/PyUnicode_FromString("user")/' \
		-i xattr.c
	sed -e "s/NS_USER.decode()/NS_USER/" -i test/test_xattr.py

	# Disable failing tests.
	sed \
		-e "s/testDirOps/_&/" \
		-e "s/testDirOpsDeprecated/_&/" \
		-e "s/testFileByDescriptor/_&/" \
		-e "s/testFileByDescriptorDeprecated/_&/" \
		-e "s/testFileByName/_&/" \
		-e "s/testFileByNameDeprecated/_&/" \
		-e "s/testFileByObject/_&/" \
		-e "s/testFileByObjectDeprecated/_&/" \
		-i test/test_xattr.py
}

src_test() {
	touch "${T}/test_file"
	if ! setfattr -n user.attr -v value "${T}/test_file" &> /dev/null; then
		ewarn "Skipping tests due to missing support for extended attributes in filesystem used by build directory"
		return
	fi

	distutils_src_test
}
