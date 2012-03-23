# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5"

inherit distutils

MY_PN="Pyro4"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Advanced and powerful Distributed Object Technology system written entirely in Python"
HOMEPAGE="http://irmen.home.xs4all.nl/pyro/ http://pypi.python.org/pypi/Pyro4"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples test"

RDEPEND="!dev-python/pyro:0"
DEPEND="${RDEPEND}
	$(python_abi_depend dev-python/setuptools)
	doc? ( $(python_abi_depend dev-python/sphinx) )
	test? ( $(python_abi_depend dev-python/nose[coverage]) )"

S="${WORKDIR}/${MY_P}"

PYTHON_MODULES="Pyro4"

src_prepare() {
	distutils_src_prepare

	sed -e '/sys.path.insert/a sys.path.insert(1,"PyroTests")' -i tests/run_suite.py

	# Disable tests requiring network connection.
	sed \
		-e "s/testBCstart/_&/" \
		-e "s/testDaemonPyroObj/_&/" \
		-e "s/testLookupAndRegister/_&/" \
		-e "s/testMulti/_&/" \
		-e "s/testRefuseDottedNames/_&/" \
		-e "s/testResolve/_&/" \
		-i tests/PyroTests/test_naming.py
	sed \
		-e "s/testOwnloopBasics/_&/" \
		-e "s/testStartNSfunc/_&/" \
		-i tests/PyroTests/test_naming2.py
	sed \
		-e "s/testServerParallelism/_&/" \
		-e "s/testServerConnections/_&/" \
		-i tests/PyroTests/test_server.py
	sed \
		-e "s/testBroadcast/_&/" \
		-e "s/testGetIP/_&/" \
		-i tests/PyroTests/test_socket.py
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		pushd docs > /dev/null
		emake html
		popd > /dev/null
	fi
}

src_test() {
	cd tests

	testing() {
		python_execute "$(PYTHON)" run_suite.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		pushd build/sphinx/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static
		popd > /dev/null
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/*
	fi
}
