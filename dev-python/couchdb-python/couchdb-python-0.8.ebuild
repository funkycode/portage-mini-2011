# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/couchdb-python/couchdb-python-0.8.ebuild,v 1.4 2011/04/11 13:35:52 phajdan.jr Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="CouchDB"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python library for working with CouchDB"
HOMEPAGE="http://code.google.com/p/couchdb-python/ http://pypi.python.org/pypi/CouchDB"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-python/httplib2
	|| ( >=dev-lang/python-2.6
		( dev-lang/python:2.5 dev-python/simplejson )
		( dev-lang/python:2.4 dev-python/simplejson ) )"
DEPEND="dev-python/setuptools"

S="${WORKDIR}/CouchDB-${PV}"

PYTHON_MODNAME="couchdb"
