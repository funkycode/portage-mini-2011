# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-perdition/selinux-perdition-2.20120215.ebuild,v 1.1 2012/03/31 12:29:09 swift Exp $
EAPI="4"

IUSE=""
MODS="perdition"
BASEPOL="2.20120215-r1"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for perdition"

KEYWORDS="~amd64 ~x86"
