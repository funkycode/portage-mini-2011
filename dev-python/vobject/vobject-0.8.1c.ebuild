# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.*"

inherit distutils

DESCRIPTION="A full featured Python package for parsing and generating vCard and vCalendar files"
HOMEPAGE="http://vobject.skyhouseconsulting.com/ http://pypi.python.org/pypi/vobject"
SRC_URI="http://vobject.skyhouseconsulting.com/${P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="$(python_abi_depend dev-python/python-dateutil)
	$(python_abi_depend dev-python/setuptools)"
RDEPEND="${DEPEND}"

DOCS="ACKNOWLEDGEMENTS.txt"

src_test() {
	testing() {
		python_execute PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test_vobject.py
	}
	python_execute_function testing
}
