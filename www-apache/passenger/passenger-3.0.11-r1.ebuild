# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/passenger/passenger-3.0.11-r1.ebuild,v 1.1 2012/02/27 20:36:03 flameeyes Exp $

EAPI=4
USE_RUBY="ruby18 ruby19"

inherit apache-module flag-o-matic ruby-ng toolchain-funcs

DESCRIPTION="Passenger (a.k.a. mod_rails) makes deployment of Ruby on Rails applications a breeze"
HOMEPAGE="http://modrails.com/"
SRC_URI="mirror://rubyforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc"

ruby_add_rdepend "
	>=dev-ruby/daemon_controller-0.2.5
	>=dev-ruby/rack-1.0.0"

USE_RUBY="ruby18" ruby_add_rdepend ">=dev-ruby/fastthread-1.0.1"

CDEPEND=">=dev-libs/libev-3.90 net-misc/curl[ssl]"

RDEPEND="${RDEPEND} ${CDEPEND}"
DEPEND="${DEPEND} ${CDEPEND}
	doc? ( >=app-text/asciidoc-8.6.5[highlight] )"

APACHE2_MOD_CONF="30_mod_${PN}-2.0.1 30_mod_${PN}"
APACHE2_MOD_DEFINE="PASSENGER"

REQUIRED_USE+="ruby_targets_ruby18? ( !ruby_targets_ruby19 )
	ruby_targets_ruby19? ( !ruby_targets_ruby18 )"

need_apache2_2

pkg_setup() {
	use debug && append-flags -DPASSENGER_DEBUG
}

all_ruby_prepare() {
	epatch "${FILESDIR}"/${PN}-3.0.8-gentoo.patch
	epatch "${FILESDIR}"/${PN}-3.0.0-ldflags.patch

	# Change these with sed instead of a patch so that we can easily use
	# the toolchain-funcs methods.
	sed -i -e "s/gcc/$(tc-getCC)/" -e "s/g++/$(tc-getCXX)/" build/config.rb || die

	# Use sed here so that we can dynamically set the documentation directory.
	sed -i -e "s:/usr/share/doc/phusion-passenger:/usr/share/doc/${P}:" \
		-e "s:/usr/lib/apache2/modules/mod_passenger.so:${APACHE_MODULESDIR}/mod_passenger.so:" \
		-e "s:/usr/lib/phusion-passenger/agents:/usr/libexec/phusion-passenger/agents:" \
		lib/phusion_passenger.rb || die
	sed -i -e "s:/usr/lib/phusion-passenger/agents:/usr/libexec/phusion-passenger/agents:" ext/common/ResourceLocator.h || die

	# Don't install a tool that won't work in our setup.
	sed -i -e '/passenger-install-apache2-module/d' lib/phusion_passenger/packaging.rb || die
	rm -f bin/passenger-install-apache2-module || die "Unable to remove unneeded install script."

	# Make sure we use the system-provided version.
	rm -rf ext/libev || die "Unable to remove vendored libev."
}

each_ruby_compile() {
	append-flags -fno-strict-aliasing

	APXS2="${APXS}" \
	HTTPD="${APACHE_BIN}" \
	USE_VENDORED_LIBEV="no" LIBEV_LIBS="-lev" \
	rake apache2 native_support || die "rake failed"

	if use doc; then
		rake doc || die "rake doc failed"
	fi
}

each_ruby_install() {
	DISTDIR="${D}" \
	APXS2="${APXS}" \
	HTTPD="${APACHE_BIN}" \
	USE_VENDORED_LIBEV="no" LIBEV_LIBS="-lev" \
	rake fakeroot || die "rake failed"

	# TODO: this will create a mess when multiple RUBY_TARGETS have been
	# selected.
	APACHE2_MOD_FILE="${S}/ext/apache2/mod_${PN}.so"
	apache-module_src_install
}
