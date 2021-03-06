# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-chdir/File-chdir-0.100.200.ebuild,v 1.2 2011/12/04 17:58:40 armin76 Exp $

EAPI=3

MODULE_AUTHOR=DAGOLDEN
MODULE_VERSION=0.1002
inherit perl-module

DESCRIPTION="An alternative to File::Spec and CWD"

SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

SRC_TEST="do"

RDEPEND=">=virtual/perl-File-Spec-3.27"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"
