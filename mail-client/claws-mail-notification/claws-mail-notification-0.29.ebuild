# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/claws-mail-notification/claws-mail-notification-0.29.ebuild,v 1.4 2012/04/07 11:33:55 maekke Exp $

EAPI=4
inherit multilib

MY_P=${PN#claws-mail-}_plugin-${PV}

DESCRIPTION="Plugin providing various ways to notify user of new and unread mail"
HOMEPAGE="http://www.claws-mail.org/"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="libnotify"

RDEPEND=">=mail-client/claws-mail-3.8.0
	>=x11-libs/gtk+-2.10:2
	libnotify? ( x11-libs/libnotify )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-static \
		$(use_enable libnotify)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README

	rm -f "${D}"/usr/$(get_libdir)/claws-mail/plugins/*.la
}
