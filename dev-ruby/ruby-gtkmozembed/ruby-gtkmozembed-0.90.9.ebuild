# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gtkmozembed/ruby-gtkmozembed-0.90.9.ebuild,v 1.1 2011/09/17 16:31:47 naota Exp $

EAPI="2"
USE_RUBY="ruby18 ruby19"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby/GTK bindings for Mozilla"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	net-libs/xulrunner"
DEPEND="${DEPEND}
	net-libs/xulrunner
	dev-util/pkgconfig"

RUBY_PATCHES=( "${PN}-0.90.8-xulrunner-1.9.2.patch" )

ruby_add_rdepend ">=dev-ruby/ruby-glib2-${PV}
	>=dev-ruby/ruby-pango-${PV}
	>=dev-ruby/ruby-gtk2-${PV}"
