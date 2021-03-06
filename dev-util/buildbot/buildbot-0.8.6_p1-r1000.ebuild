# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.* *-jython"
DISTUTILS_SRC_TEST="trial"
DISTUTILS_DISABLE_TEST_DEPENDENCY="1"

inherit distutils user

MY_PV="${PV/_p/p}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="BuildBot build automation system"
HOMEPAGE="http://trac.buildbot.net/ http://code.google.com/p/buildbot/ http://pypi.python.org/pypi/buildbot"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh sparc x86"
IUSE="doc examples irc mail manhole test"

RDEPEND="$(python_abi_depend ">=dev-python/jinja-2.1")
	$(python_abi_depend dev-python/sqlalchemy)
	|| (
		$(python_abi_depend "=dev-python/sqlalchemy-migrate-0.7*")
		$(python_abi_depend "=dev-python/sqlalchemy-migrate-0.6*")
	)
	$(python_abi_depend ">=dev-python/twisted-8.0.0")
	$(python_abi_depend dev-python/twisted-web)
	$(python_abi_depend virtual/python-json[external])
	$(python_abi_depend virtual/python-sqlite[external])
	irc? ( $(python_abi_depend dev-python/twisted-words) )
	mail? ( $(python_abi_depend dev-python/twisted-mail) )
	manhole? ( $(python_abi_depend -e "*-pypy-*" dev-python/twisted-conch) )"
DEPEND="${DEPEND}
	$(python_abi_depend dev-python/setuptools)
	doc? ( $(python_abi_depend dev-python/sphinx) )
	test? (
		$(python_abi_depend dev-python/mock)
		$(python_abi_depend dev-python/twisted-mail)
		$(python_abi_depend dev-python/twisted-web)
		$(python_abi_depend dev-python/twisted-words)
	)"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	python_pkg_setup
	enewuser buildbot
}

src_prepare() {
	distutils_src_prepare
	sed -e "s/sqlalchemy-migrate ==0.6.0, ==0.6.1, ==0.7.0, ==0.7.1, ==0.7.2/sqlalchemy-migrate ==0.6, ==0.7/" -i setup.py
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

src_install() {
	distutils_src_install

	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/buildbot/test"
	}
	python_execute_function -q delete_tests

	doman docs/buildbot.1

	if use doc; then
		pushd docs/_build/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _images _static
		popd > /dev/null
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r contrib docs/examples
	fi

	newconfd "${FILESDIR}/buildmaster.confd" buildmaster
	newinitd "${FILESDIR}/buildmaster.initd" buildmaster
}

pkg_postinst() {
	distutils_pkg_postinst

	elog "The \"buildbot\" user and the \"buildmaster\" init script has been added"
	elog "to support starting buildbot through Gentoo's init system. To use this,"
	elog "set up your build master following the documentation, make sure the"
	elog "resulting directories are owned by the \"buildbot\" user and point"
	elog "\"${ROOT}etc/conf.d/buildmaster\" at the right location. The scripts can"
	elog "run as a different user if desired. If you need to run more than one"
	elog "build master, just copy the scripts."
	elog
	elog "Upstream recommends the following when upgrading:"
	elog "Each time you install a new version of Buildbot, you should run the"
	elog "\"buildbot upgrade-master\" command on each of your pre-existing build masters."
	elog "This will add files and fix (or at least detect) incompatibilities between"
	elog "your old config and the new code."
}
