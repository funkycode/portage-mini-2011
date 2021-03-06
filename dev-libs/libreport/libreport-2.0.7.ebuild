# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libreport/libreport-2.0.7.ebuild,v 1.5 2012/01/14 15:54:48 maekke Exp $

EAPI="4"
PYTHON_DEPEND="2:2.6"

inherit autotools eutils python

DESCRIPTION="Generic library for reporting software bugs"
HOMEPAGE="https://fedorahosted.org/abrt/"
SRC_URI="https://fedorahosted.org/released/abrt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

RDEPEND=">=dev-libs/glib-2.21:2
	dev-libs/newt
	dev-libs/nss
	dev-libs/libtar
	dev-libs/libxml2
	dev-libs/xmlrpc-c
	gnome-base/gnome-keyring
	net-misc/curl[ssl]
	sys-apps/dbus
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	app-text/asciidoc
	app-text/xmlto
	>=dev-util/intltool-0.3.50
	>=dev-util/pkgconfig-0.9.0
	>=sys-devel/gettext-0.17"

# Tests require python-meh, which is highly redhat-specific.
RESTRICT="test"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup

	enewgroup abrt
	enewuser abrt -1 -1 -1 abrt
}

src_prepare() {
	# Replace redhat-specific defaults with gentoo ones
	epatch "${FILESDIR}/${PN}-2.0.7-gentoo.patch"

	# Disable bugzilla plugin for now (requires bugs.gentoo.org infra support)
	epatch "${FILESDIR}/${PN}-2.0.7-no-bugzilla.patch"

	# Modify uploader_event so that the gui recognizes it
	epatch "${FILESDIR}/${PN}-2.0.7-uploader_event-syntax.patch"

	# https://bugzilla.redhat.com/show_bug.cgi?id=751833, in next release
	epatch "${FILESDIR}/${P}-multiple-tabs.patch"

	# -Werror should not be used by default
	sed -e "s/-Werror\( \|$\)//" \
		-i src/client-python/Makefile.* src/cli/Makefile.* \
		   src/gtk-helpers/Makefile.* src/gui-wizard-gtk/Makefile.* \
		   src/lib/Makefile.* src/plugins/Makefile.* \
		   src/report-python/Makefile.* || die "sed failed"

	# disable pyc compiling
	echo '#!/bin/sh' > py-compile

	mkdir m4
	eautoreconf
}

src_configure() {
	# Gentoo's xmlrpc-c does not provide a pkgconfig file
	# XXX: this is probably cross-compile-unfriendly
	export XMLRPC_CFLAGS=$(xmlrpc-c-config --cflags)
	export XMLRPC_LIBS=$(xmlrpc-c-config --libs)
	export XMLRPC_CLIENT_CFLAGS=$(xmlrpc-c-config client --cflags)
	export XMLRPC_CLIENT_LIBS=$(xmlrpc-c-config client --libs)
	# Configure checks for python.pc; our python-2.7 installs python-2.7.pc,
	# while python-2.6 does not install any pkgconfig file.
	export PYTHON_CFLAGS=$(python-config --includes)
	export PYTHON_LIBS=$(python-config --libs)

	ECONF="--disable-bodhi
		--localstatedir=${EPREFIX}/var"
	# --disable-debug enables debug!
	use debug && ECONF="${ECONF} --enable-debug"
	econf ${ECONF}
}

src_install() {
	default

	# Need to set correct ownership for use by app-admin/abrt
	diropts -o abrt -g abrt
	keepdir /var/spool/abrt

	find "${D}" -name '*.la' -exec rm -f {} + || die
}

pkg_postinst() {
	python_mod_optimize report reportclient
}

pkg_postrm() {
	python_mod_cleanup report reportclient
}
