# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-bacula/selinux-bacula-2.20120215.ebuild,v 1.1 2012/03/31 12:29:43 swift Exp $
EAPI="4"

IUSE=""
MODS="bacula"
BASEPOL="2.20120215-r1"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for bacula"

KEYWORDS="~amd64 ~x86"
