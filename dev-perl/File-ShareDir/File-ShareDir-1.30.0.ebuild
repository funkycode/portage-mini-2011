# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-ShareDir/File-ShareDir-1.30.0.ebuild,v 1.4 2012/03/20 22:06:54 jer Exp $

EAPI=4

MODULE_AUTHOR=ADAMK
MODULE_VERSION=1.03
inherit perl-module

DESCRIPTION="Locate per-dist and per-module shared files"

SLOT="0"
KEYWORDS="amd64 hppa ~x86 ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/Class-Inspector"
DEPEND="${RDEPEND}"

SRC_TEST="do"
