# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/aplpy/aplpy-0.9.7.ebuild,v 1.1 2012/03/02 05:37:08 bicatali Exp $

EAPI=2

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MYP=APLpy-${PV}

DESCRIPTION="Astronomical Plotting Library in Python"
HOMEPAGE="http://aplpy.github.com/ http://pypi.python.org/pypi/APLpy"
SRC_URI="https://github.com/downloads/${PN}/${PN}/${MYP}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/numpy"
RDEPEND="${DEPEND}
	dev-python/matplotlib
	dev-python/pyfits
	dev-python/pywcs"

RESTRICT_PYTHON_ABIS="3.*"

S=${WORKDIR}/${MYP}
