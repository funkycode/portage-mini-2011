# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gsettings-desktop-schemas/gsettings-desktop-schemas-3.0.1.ebuild,v 1.8 2011/10/30 16:11:25 armin76 Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Collection of GSettings schemas for GNOME desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~sparc-solaris ~x86-solaris"

RDEPEND=">=dev-libs/glib-2.21:2"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.40"

DOCS="AUTHORS HACKING NEWS README"
