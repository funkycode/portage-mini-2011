# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.* *-jython"
MY_PACKAGE="Mail"

inherit twisted versionator

DESCRIPTION="A Twisted Mail library, server and client"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ia64-hpux ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND="$(python_abi_depend "=dev-python/twisted-$(get_version_component_range 1-2)*")
	$(python_abi_depend "=dev-python/twisted-names-$(get_version_component_range 1-2)*")"
RDEPEND="${DEPEND}"

PYTHON_MODULES="twisted/mail twisted/plugins"
