# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/polysh/polysh-0.4.ebuild,v 1.2 2012/02/10 02:55:20 patrick Exp $

EAPI=3
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Aggregate several remote shells into one"
HOMEPAGE="http://guichaz.free.fr/polysh/"
SRC_URI="http://guichaz.free.fr/polysh/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""
