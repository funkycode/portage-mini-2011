# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/iobuffer/iobuffer-1.1.2-r1.ebuild,v 1.1 2012/03/14 18:05:54 matsuu Exp $

EAPI="4"
# jruby: mkmf
# rbx: Kernel(Autoload)#allocate (method_missing)
USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGES.md README.md"

RUBY_FAKEGEM_TASK_TEST="spec"

inherit ruby-fakegem

GITHUB_USER="tarcieri"

DESCRIPTION="IO::Buffer is a fast byte queue which is primarily intended for non-blocking I/O applications"
HOMEPAGE="http://github.com/tarcieri/iobuffer"
SRC_URI="http://github.com/${GITHUB_USER}/iobuffer/tarball/v${PV} -> ${PN}-git-${PV}.tgz"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86 ~x86-macos"
SLOT="0"
IUSE=""

RUBY_S="${GITHUB_USER}-${PN}-*"

ruby_add_bdepend "test? ( dev-ruby/bundler dev-ruby/rspec )"

all_ruby_prepare() {
	rm .rspec || die
}

each_ruby_configure() {
	${RUBY} -C ext extconf.rb || die "Failed to configure the extension."
	sed -i -e 's:-Wl,--no-undefined::' \
		-e "s/^ldflags  = /ldflags = $\(LDFLAGS\) /" ext/Makefile || die
}

each_ruby_compile() {
	emake -C ext || die "Failed to compile the extension."
	cp ext/iobuffer_ext.so lib/ || die
}
