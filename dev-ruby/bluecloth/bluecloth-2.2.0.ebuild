# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/bluecloth/bluecloth-2.2.0.ebuild,v 1.2 2012/01/03 18:15:15 jer Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_EXTRADOC="History.rdoc README.rdoc"
RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem eutils

DESCRIPTION="A Ruby implementation of Markdown"
HOMEPAGE="http://www.deveiate.org/projects/BlueCloth"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="test"

DEPEND="${DEPEND} doc? ( dev-lang/perl )"
RDEPEND="${RDEPEND}"

ruby_add_bdepend "
	dev-ruby/hoe
	dev-ruby/rake-compiler
	test? (
		>=dev-ruby/rspec-2.4:2
		dev-ruby/diff-lcs
		dev-ruby/tidy-ext
	)"

all_ruby_prepare() {
	# for Ruby 1.9.2 compatibility
	sed -i -e '1i $: << "."' Rakefile || die
}

all_ruby_compile() {
	rake man/man1/bluecloth.1

	all_fakegem_compile
}

each_ruby_compile() {
	${RUBY} -S rake compile || die "extension build failed"
}

each_ruby_test() {
	${RUBY} -S rspec spec || die "tests failed"
}

all_ruby_install() {
	doman man/man1/bluecloth.1

	all_fakegem_install
}
