# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-poppler/ruby-poppler-0.90.8.ebuild,v 1.2 2012/02/06 17:31:24 ranger Exp $

EAPI="2"
USE_RUBY="ruby18 ruby19"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby poppler-glib bindings"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	app-text/poppler[cairo]"
DEPEND="${DEPEND}
	app-text/poppler[cairo]
	dev-util/pkgconfig"

ruby_add_rdepend "dev-ruby/ruby-gdkpixbuf2
	>=dev-ruby/ruby-glib2-${PV}
	>=dev-ruby/ruby-gtk2-${PV}"
