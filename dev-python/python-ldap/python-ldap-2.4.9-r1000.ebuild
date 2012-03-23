# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.* *-jython"

inherit distutils multilib

DOC_P="${PN}-docs-html-2.4.4"

DESCRIPTION="Python modules for implementing LDAP clients"
HOMEPAGE="http://python-ldap.org/ http://sourceforge.net/projects/python-ldap/ http://pypi.python.org/pypi/python-ldap"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
	doc? ( http://www.python-ldap.org/doc/${DOC_P}.tar.gz )"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-solaris"
IUSE="doc examples sasl ssl"

RDEPEND=">=net-nds/openldap-2.4.11
	sasl? ( dev-libs/cyrus-sasl )"
DEPEND="${DEPEND}
	$(python_abi_depend dev-python/setuptools)"

DOCS="CHANGES README"
PYTHON_MODULES="dsml.py ldap ldapurl.py ldif.py"

src_prepare() {
	distutils_src_prepare

	local defines extra_link_args include_dirs libs
	libs="ldap"

	if use sasl; then
		include_dirs+=" ${EPREFIX}/usr/include/sasl"
		defines+=" HAVE_SASL"
		[[ "${CHOST}" != *-darwin* ]] && extra_link_args="-Wl,-rpath=${EPREFIX}/usr/$(get_libdir)/sasl2"
		use ssl && libs="ldap_r"
		libs+=" sasl2"
	fi

	if use ssl; then
		defines+=" HAVE_TLS"
		libs+=" ssl crypto"
	fi

	sed \
		-e "s:^\(library_dirs =\).*:\1:" \
		-e "s:^\(include_dirs =\).*:\1 ${include_dirs}:" \
		-e "s:^\(defines =\).*:\1 ${defines}:" \
		-e "s:^\(extra_compile_args =\).*:\1:" \
		-e "/^extra_compile_args/a extra_link_args = ${extra_link_args}" \
		-e "s:^\(libs =\).*:\1 lber resolv ${libs}:" \
		-i setup.cfg || die "sed failed"
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r "${WORKDIR}/${DOC_P}"/*
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r Demo/*
	fi
}
