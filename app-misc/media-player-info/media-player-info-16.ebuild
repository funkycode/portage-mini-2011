# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/media-player-info/media-player-info-16.ebuild,v 1.3 2012/02/01 01:47:02 ssuominen Exp $

EAPI=4

DESCRIPTION="A repository of data files describing media player capabilities"
HOMEPAGE="http://cgit.freedesktop.org/media-player-info/"
SRC_URI="http://www.freedesktop.org/software/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ppc ppc64 ~sh ~sparc x86"
IUSE=""

RDEPEND="sys-fs/udev"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS NEWS README"

# This ebuild does not install any binaries
RESTRICT="binchecks strip"
