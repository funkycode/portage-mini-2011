# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-GDOME/XML-GDOME-0.860.0.ebuild,v 1.2 2011/09/03 21:04:41 tove Exp $

EAPI=4

MODULE_AUTHOR=TJMATHER
MODULE_VERSION=0.86
inherit perl-module

DESCRIPTION="Provides the DOM Level 2 Core API for accessing XML documents"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86"
IUSE=""

RDEPEND=">=dev-libs/gdome2-0.7.2
	>=dev-perl/XML-LibXML-1.70
	dev-perl/XML-SAX
	>=dev-libs/glib-2.2.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

PATCHES=( "${FILESDIR}"/0.86-includes.patch )
