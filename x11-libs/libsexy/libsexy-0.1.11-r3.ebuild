# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libsexy/libsexy-0.1.11-r3.ebuild,v 1.2 2011/10/16 20:06:20 ssuominen Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="Sexy GTK+ Widgets"
HOMEPAGE="http://www.chipx86.com/wiki/Libsexy"
SRC_URI="http://releases.chipx86.com/${PN}/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="doc static-libs"

RDEPEND=">=dev-libs/glib-2.6:2
	>=x11-libs/gtk+-2.6:2
	dev-libs/libxml2
	>=x11-libs/pango-1.4.0
	>=app-text/iso-codes-0.49"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	>=dev-util/pkgconfig-0.19
	dev-util/gtk-doc-am
	doc? ( >=dev-util/gtk-doc-1.4 )"

DOCS=( AUTHORS ChangeLog NEWS )

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-fix-null-list.patch \
		"${FILESDIR}"/${P}-pkgconfig-pollution.patch

	sed -i \
		-e 's:noinst_PROGRAMS:check_PROGRAMS:' \
		tests/Makefile.am || die

	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable doc gtk-doc) \
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
}
