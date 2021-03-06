# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libupnp/libupnp-1.6.14.ebuild,v 1.1 2011/12/15 21:32:52 gurligebis Exp $

EAPI="4"
WANT_AUTOMAKE=1.9

inherit eutils flag-o-matic autotools

DESCRIPTION="An Portable Open Source UPnP Development Kit"
HOMEPAGE="http://pupnp.sourceforge.net/"
SRC_URI="mirror://sourceforge/pupnp/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm ~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug doc ipv6 static-libs"

RDEPEND=""
DEPEND="${RDEPEND}"

DOCS="NEWS README ChangeLog"

src_prepare() {
	sed -e '/AX_CFLAGS_GCC_OPTION/s:-Os::g' \
		-i "${S}/configure.ac" || die

	# fix tests
	chmod +x ixml/test/test_document.sh || die

	eautoreconf
}

src_configure() {
	use x86-fbsd &&	append-flags -O1
	# w/o docdir to avoid sandbox violations
	econf \
		$(use_enable debug) \
		$(use_enable ipv6) \
		$(use_enable static-libs static) \
		$(use_with doc documentation "${EPREFIX}/usr/share/doc/${PF}")
}

src_install () {
	default
	dobin upnp/sample/.libs/tv_{combo,ctrlpt,device}
	use static-libs || find "${ED}" -type f -name '*.la' -delete
}

pkg_postinst() {
	ewarn "Please remember to run revdep-rebuild when upgrading"
	ewarn "from libupnp 1.4.x to libupnp 1.6.x , so packages"
	ewarn "gets linked with the new library."
	ewarn ""
	ewarn "The revdep-rebuild script is part of the"
	ewarn "app-portage/gentoolkit package."
}
