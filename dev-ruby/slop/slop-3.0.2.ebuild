# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/slop/slop-3.0.2.ebuild,v 1.2 2012/03/11 12:54:25 ranger Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGES.md README.md"

inherit ruby-fakegem

DESCRIPTION="A simple option parser with an easy to remember syntax and friendly API."
HOMEPAGE="https://github.com/injekt/slop"
SRC_URI="https://github.com/injekt/slop/tarball/v${PV} -> ${P}.tgz"
RUBY_S="injekt-slop-*"

LICENSE="MIT"
SLOT="3"
KEYWORDS="~amd64 ~ppc64"

IUSE=""

ruby_add_bdepend "test? ( dev-ruby/minitest )"
