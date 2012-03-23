# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="Abstract Syntax Tree New Generation for logilab packages"
HOMEPAGE="http://www.logilab.org/projects/astng/ http://pypi.python.org/pypi/logilab-astng"
SRC_URI="ftp://ftp.logilab.org/pub/astng/logilab-${P}.tar.gz mirror://pypi/l/logilab-astng/logilab-${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x64-macos ~x86-macos"
IUSE="test"

# Version specified in __pkginfo__.py.
RDEPEND="$(python_abi_depend ">=dev-python/logilab-common-0.53.0")"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)
	test? ( $(python_abi_depend -e "3.* *-jython *-pypy-*" ">=dev-python/egenix-mx-base-3.0.0") )"

S="${WORKDIR}/logilab-${P}"

PYTHON_MODULES="logilab/astng"

src_test() {
	testing() {
		local tpath="${T}/test-${PYTHON_ABI}"
		local spath="${tpath}$(python_get_sitedir)"

		mkdir -p "${spath}/logilab" || return 1
		cp -r "$(python_get_sitedir)/logilab/common" "${spath}/logilab" || return 1

		python_execute "$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" install --root="${tpath}" || die "Installation for tests failed with $(python_get_implementation_and_version)"

		# pytest uses tests placed relatively to the current directory.
		pushd "${spath}/logilab/astng" > /dev/null || return 1
		python_execute PYTHONPATH="${spath}" pytest -v || return 1
		popd > /dev/null || return 1
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	delete_unneeded_files() {
		# Avoid collisions with dev-python/logilab-common.
		rm -f "${ED}$(python_get_sitedir)/logilab/__init__.py" || return 1

		# Don't install tests.
		rm -fr "${ED}$(python_get_sitedir)/logilab/astng/test" || return 1
	}
	python_execute_function -q delete_unneeded_files
}
