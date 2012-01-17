# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3

inherit distutils bzr

SUPPORT_PYTHON_ABIS="1"

: ${EBZR_REPO_URI:="lp:${PN}"}

DESCRIPTION="Fastimport parser in Python"
HOMEPAGE="https://launchpad.net/${PN}"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
