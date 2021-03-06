# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pianobar/pianobar-9999.ebuild,v 1.1 2012/01/13 07:04:25 radhermit Exp $

EAPI="4"

inherit toolchain-funcs flag-o-matic eutils git-2

EGIT_REPO_URI="git://github.com/PromyLOPh/pianobar.git"

DESCRIPTION="A console-based replacement for Pandora's flash player"
HOMEPAGE="http://6xq.net/projects/pianobar/"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS=""
IUSE="aac +mp3"

DEPEND="media-libs/libao
	net-libs/gnutls
	aac? ( media-libs/faad2 )
	mp3? ( media-libs/libmad )"
RDEPEND="${DEPEND}"

REQUIRED_USE="|| ( mp3 aac )"

# Only releases are tested since patches required for testing often break
RESTRICT="test"

src_compile() {
	local myconf
	! use aac && myconf+=" DISABLE_FAAD=1"
	! use mp3 && myconf+=" DISABLE_MAD=1"

	append-cflags -std=c99
	tc-export CC
	emake ${myconf}
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
	dodoc ChangeLog README

	docinto contrib
	dodoc -r contrib/{config-example,*.sh,eventcmd-examples}
	docompress -x /usr/share/doc/${PF}/contrib
}
