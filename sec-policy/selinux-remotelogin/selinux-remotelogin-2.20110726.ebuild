# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-remotelogin/selinux-remotelogin-2.20110726.ebuild,v 1.2 2012/01/29 11:23:10 swift Exp $
EAPI="4"

IUSE=""
MODS="remotelogin"
BASEPOL="2.20110726-r8"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for remotelogin"

KEYWORDS="amd64 x86"
