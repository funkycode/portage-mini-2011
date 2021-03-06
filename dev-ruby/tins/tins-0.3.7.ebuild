# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/tins/tins-0.3.7.ebuild,v 1.1 2012/01/28 11:16:55 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

RUBY_FAKEGEM_GEMSPEC="tins.gemspec"

inherit ruby-fakegem

DESCRIPTION="All the stuff that isn't good enough for a real library."
HOMEPAGE="http://github.com/flori/tins"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( >=dev-ruby/test-unit-2.3 ) "

all_ruby_prepare() {
	sed -i -e '/gem_hadar/ s:^:#:' tests/test_helper.rb || die
}

each_ruby_test() {
	${RUBY} -Ilib -S testrb tests/* || die
}
