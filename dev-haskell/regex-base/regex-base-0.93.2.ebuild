# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/regex-base/regex-base-0.93.2.ebuild,v 1.3 2012/04/05 20:48:44 phajdan.jr Exp $

CABAL_FEATURES="profile haddock lib"
inherit haskell-cabal

DESCRIPTION="Interface API for regex-posix,pcre,parsec,tdfa,dfa"
HOMEPAGE="http://sourceforge.net/projects/lazy-regex"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6
		dev-haskell/mtl"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"
