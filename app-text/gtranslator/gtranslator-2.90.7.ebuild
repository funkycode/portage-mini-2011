# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gtranslator/gtranslator-2.90.7.ebuild,v 1.3 2012/02/24 23:57:57 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_DEPEND="gnome? 2"
GNOME_TARBALL_SUFFIX="bz2"

inherit autotools eutils gnome2 multilib python

DESCRIPTION="An enhanced gettext po file editor for GNOME"
HOMEPAGE="http://gtranslator.sourceforge.net/"
SRC_URI="${SRC_URI} mirror://gentoo/introspection.m4.bz2" # for eautoreconf

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc gnome spell"

COMMON_DEPEND="
	>=dev-libs/glib-2.28.0:2
	>=x11-libs/gtk+-3.0.3:3
	>=x11-libs/gtksourceview-3.0.0:3.0
	>=dev-libs/gdl-2.91.91:3
	>=dev-libs/libxml2-2.4.12:2
	>=dev-libs/json-glib-0.12.0
	>=dev-libs/libpeas-1.0.0[gtk]
	>=gnome-extra/libgda-4.2.0:4
	>=app-text/iso-codes-0.35

	gnome-base/gsettings-desktop-schemas

	gnome? (
		gnome-extra/gnome-utils
		x11-libs/gtk+:3[introspection] )
	spell? ( app-text/gtkspell:3 )"
RDEPEND="${COMMON_DEPEND}
	gnome? (
		>=dev-libs/libpeas-1.0.0[gtk,python]
		|| ( dev-python/pygobject:2[introspection] dev-python/pygobject:3 )
		gnome-extra/gucharmap:2.90[introspection] )"
DEPEND="${COMMON_DEPEND}
	>=app-text/scrollkeeper-0.1.4
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.17
	dev-util/pkgconfig
	app-text/gnome-doc-utils
	app-text/docbook-xml-dtd:4.1.2
	doc? ( >=dev-util/gtk-doc-1 )

	gnome-base/gnome-common"
# eautoreconf requires gnome-base/gnome-common

pkg_setup() {
	DOCS="AUTHORS ChangeLog HACKING INSTALL NEWS README THANKS"
	G2CONF="${G2CONF}
		--disable-static
		$(use_with gnome dictionary)
		$(use_enable gnome introspection)
		$(use_with spell gtkspell3)"

	if use gnome; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	# Fix gtkspell detection, https://bugzilla.gnome.org/show_bug.cgi?id=660709
	epatch "${FILESDIR}/${PN}-2.90.6-gtkspell3.patch"

	# introspection.m4 needed for eautoreconf
	mv "${WORKDIR}/introspection.m4" "${S}/m4/" || die

	eautoreconf

	gnome2_src_prepare

	if use gnome; then
		python_clean_py-compile_files
	else
		# don't install charmap plugin, it requires gnome-extra/gucharmap
		sed -e 's:\scharmap\s: :g' -i plugins/Makefile.* ||
			die "sed plugins/Makefile.* failed"
	fi
}

pkg_postinst() {
	gnome2_pkg_postinst
	if use gnome; then
		python_need_rebuild
		python_mod_optimize /usr/$(get_libdir)/gtranslator/plugins
	fi
}

pkg_postrm() {
	gnome2_pkg_postrm
	use gnome && python_mod_cleanup /usr/$(get_libdir)/gtranslator/plugins
}
