# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tk-CursorControl/Tk-CursorControl-0.400.0.ebuild,v 1.2 2011/09/03 21:04:30 tove Exp $

EAPI=4

MODULE_AUTHOR=DUNNIGANJ
MODULE_VERSION=0.4
inherit eutils perl-module

DESCRIPTION="Manipulate the mouse cursor programmatically"

SLOT="0"
KEYWORDS="amd64 ia64 sparc x86"
IUSE=""

RDEPEND="dev-perl/perl-tk"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/0.4-demo.patch" )

src_prepare() {
	perl-module_src_prepare
	edos2unix "${S}"/{CursorControl.pm,demos/cursor.pl} || die
}