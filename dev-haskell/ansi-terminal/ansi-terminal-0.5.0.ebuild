# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/ansi-terminal/ansi-terminal-0.5.0.ebuild,v 1.9 2011/02/25 13:10:25 xarthisius Exp $

CABAL_FEATURES="bin lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Simple ANSI terminal support, with Windows compatibility"
HOMEPAGE="http://github.com/batterseapower/ansi-terminal"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-lang/ghc-6.8
		>=dev-haskell/cabal-1.2"
