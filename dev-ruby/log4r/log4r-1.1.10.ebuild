# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/log4r/log4r-1.1.10.ebuild,v 1.2 2012/03/21 06:47:56 graaff Exp $

EAPI="2"
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""

# There are no working tests atm, to be checked on next version bump.
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_DOCDIR="doc"

inherit ruby-fakegem

DESCRIPTION="Log4r is a comprehensive and flexible logging library written in
Ruby for use in Ruby programs."
HOMEPAGE="http://log4r.sourceforge.net/"
IUSE=""

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"

all_ruby_install() {
	all_fakegem_install

	insinto /usr/share/doc/${PF}
	doins -r examples || die
}
