# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyds9/pyds9-1.3.ebuild,v 1.3 2012/02/23 07:19:29 patrick Exp $

EAPI=3

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-* *-jython"

inherit distutils multilib

DESCRIPTION="Python interface to XPA to communicate with DS9"
HOMEPAGE="http://hea-www.harvard.edu/saord/ds9/pyds9/"
SRC_URI="http://hea-www.harvard.edu/saord/download/ds9/python/${P}.tar.gz"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

DEPEND="x11-libs/xpa"
RDEPEND="${DEPEND}
	dev-python/numpy
	dev-python/pyfits"

DOCS="changelog README"

src_prepare() {
	rm -rf xpa-*
	sed -i \
		-e "/py_modules/s|\],|\])|" \
		-e '/data_files/,$ d' \
		setup.py || die
	sed -i \
		-e "s|./xpa-2.1.12|${EROOT}/usr/$(get_libdir)|" \
		xpa.py || die
	sed -i \
		-e "s|sys.path|${EROOT}/usr/bin|" \
		ds9.py || die
	distutils_src_prepare
}
