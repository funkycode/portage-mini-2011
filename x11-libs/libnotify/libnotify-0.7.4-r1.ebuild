# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libnotify/libnotify-0.7.4-r1.ebuild,v 1.1 2012/01/23 01:50:33 ssuominen Exp $

EAPI=4
inherit autotools gnome.org

DESCRIPTION="A library for sending desktop notifications"
HOMEPAGE="http://git.gnome.org/browse/libnotify"
SRC_URI="${SRC_URI}
	mirror://gentoo/introspection-20110205.m4.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="doc +introspection +symlink test"

RDEPEND=">=dev-libs/glib-2.26
	x11-libs/gdk-pixbuf:2
	introspection? ( >=dev-libs/gobject-introspection-0.9.12 )"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.14 )
	symlink? ( !x11-misc/tinynotify-send[symlink] )
	test? ( x11-libs/gtk+:3 )"
PDEPEND="virtual/notification-daemon"

DOCS=( AUTHORS ChangeLog NEWS )

src_prepare() {
	sed -i -e 's:noinst_PROG:check_PROG:' tests/Makefile.am || die

	if ! use test; then
		sed -i -e '/PKG_CHECK_MODULES(TESTS/d' configure.ac || die
	fi

	if has_version 'dev-libs/gobject-introspection'; then
		eautoreconf
	else
		AT_M4DIR=${WORKDIR} eautoreconf
	fi
}

src_configure() {
	econf \
		--disable-static \
		$(use_enable introspection)
}

src_install() {
	default
	rm -f "${ED}"usr/lib*/${PN}.la
	mv -vf "${ED}"usr/bin/{,${PN}-}notify-send #379941
	use symlink && dosym ${PN}-notify-send /usr/bin/notify-send
}
