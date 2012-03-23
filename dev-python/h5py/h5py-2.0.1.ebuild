# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 *-jython *-pypy-*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="A simple Python interface to HDF5 files."
HOMEPAGE="http://h5py.alfven.org/ http://code.google.com/p/h5py/ http://pypi.python.org/pypi/h5py"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="sci-libs/hdf5
	$(python_abi_depend dev-python/numpy)"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)
	test? ( $(python_abi_depend dev-python/unittest2) )"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"
