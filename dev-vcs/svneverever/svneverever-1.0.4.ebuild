# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/svneverever/svneverever-1.0.4.ebuild,v 1.1 2011/01/19 00:10:36 sping Exp $

EAPI="2"

PYTHON_DEPEND="*:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45]"

inherit distutils

DESCRIPTION="Tool collecting path entries across SVN history"
HOMEPAGE="http://git.goodpoint.de/?p=svneverever.git;a=summary"
SRC_URI="http://www.hartwork.org/public/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/pysvn"
