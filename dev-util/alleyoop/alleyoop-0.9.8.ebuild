# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/alleyoop/alleyoop-0.9.8.ebuild,v 1.1 2011/12/31 18:07:06 pacho Exp $

EAPI="4"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="A Gtk+ front-end to the Valgrind memory checker for x86 GNU/ Linux."
HOMEPAGE="http://alleyoop.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-alpha ~amd64 ~ppc -sparc ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.14:2
	>=x11-libs/gtk+-2.2:2
	>=gnome-base/gconf-2.2:2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/libglade-2.2
	sys-devel/binutils
	>=dev-util/valgrind-2.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"
