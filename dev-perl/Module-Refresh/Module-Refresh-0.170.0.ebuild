# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Refresh/Module-Refresh-0.170.0.ebuild,v 1.3 2012/04/04 08:53:20 jdhore Exp $

EAPI=4

MODULE_AUTHOR=ALEXMV
MODULE_VERSION=0.17
inherit perl-module

DESCRIPTION="Refresh %INC files when updated on disk"

SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc x86"
IUSE="test"

RDEPEND=""
DEPEND="test? ( dev-perl/Path-Class )"

SRC_TEST="do"
