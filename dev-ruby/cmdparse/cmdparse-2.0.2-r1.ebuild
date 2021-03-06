# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/cmdparse/cmdparse-2.0.2-r1.ebuild,v 1.5 2011/01/09 16:51:16 armin76 Exp $

EAPI=2

USE_RUBY="ruby18 jruby"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_DOCDIR="doc/output/rdoc"
RUBY_FAKEGEM_EXTRADOC="ChangeLog README TODO VERSION"

inherit ruby-fakegem

IUSE=""

DESCRIPTION="Advanced command line parser supporting commands"
HOMEPAGE="http://cmdparse.rubyforge.org/"

KEYWORDS="~amd64 ia64 ppc64 x86"
LICENSE="GPL-2"
SLOT="0"

each_ruby_test() {
	${RUBY} -Ilib net.rb stat || die "test failed"
}
