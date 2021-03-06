# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_TESTS_RESTRICTED_ABIS="3.* *-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="SQLAlchemy"
MY_P="${MY_PN}-${PV/_}"

DESCRIPTION="Python SQL toolkit and Object Relational Mapper"
HOMEPAGE="http://www.sqlalchemy.org/ http://pypi.python.org/pypi/SQLAlchemy"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ppc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="doc examples firebird mssql mysql postgres +sqlite test"

RDEPEND="$(python_abi_depend dev-python/setuptools)
	firebird? ( $(python_abi_depend -e "3.* *-jython *-pypy-*" dev-python/kinterbasdb) )
	mssql? ( $(python_abi_depend -e "3.* *-jython *-pypy-*" dev-python/pymssql) )
	mysql? ( $(python_abi_depend -e "3.* *-jython" dev-python/mysql-python) )
	postgres? ( $(python_abi_depend -e "*-jython *-pypy-*" dev-python/psycopg:2) )
	sqlite? ( $(python_abi_depend -e "*-jython" virtual/python-sqlite[external]) )"
DEPEND="${RDEPEND}
	test? ( $(python_abi_depend -e "3.* *-jython" virtual/python-sqlite[external]) )"

S="${WORKDIR}/${MY_P}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DISTUTILS_GLOBAL_OPTIONS=("2.*-cpython --with-cextensions")

src_prepare() {
	distutils_src_prepare

	# Disable tests hardcoding function call counts specific to Python versions.
	rm -fr test/aaa_profiling
}

src_test() {
	testing() {
		python_execute PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib*)" "$(PYTHON)" sqla_nose.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		pushd doc > /dev/null
		rm -fr build
		dohtml -r [a-z]* _images _static
		popd > /dev/null
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
