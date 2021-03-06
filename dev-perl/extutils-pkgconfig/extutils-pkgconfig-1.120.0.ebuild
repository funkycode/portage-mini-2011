# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/extutils-pkgconfig/extutils-pkgconfig-1.120.0.ebuild,v 1.8 2012/03/25 17:33:46 armin76 Exp $

EAPI=4

MY_PN=ExtUtils-PkgConfig
MODULE_AUTHOR=TSCH
MODULE_VERSION=1.12
inherit perl-module

DESCRIPTION="Simplistic perl interface to pkg-config"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

DEPEND="dev-util/pkgconfig"
RDEPEND="${DEPEND}"

SRC_TEST="do"
