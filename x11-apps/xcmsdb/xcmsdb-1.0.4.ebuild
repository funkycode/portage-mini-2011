# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xcmsdb/xcmsdb-1.0.4.ebuild,v 1.1 2012/02/24 15:36:44 chithanh Exp $

EAPI=4

inherit xorg-2

DESCRIPTION="Device Color Characterization utility for X Color Management System"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}"
