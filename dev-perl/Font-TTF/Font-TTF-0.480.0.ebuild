# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Font-TTF/Font-TTF-0.480.0.ebuild,v 1.9 2012/03/25 15:05:56 armin76 Exp $

EAPI=4

MODULE_AUTHOR=MHOSKEN
MODULE_VERSION=0.48
inherit perl-module

DESCRIPTION="module for compiling and altering fonts"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="virtual/perl-IO-Compress
	dev-perl/XML-Parser"
DEPEND="${RDEPEND}"

SRC_TEST="do"
