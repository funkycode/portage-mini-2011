# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/dfu-util/dfu-util-0.4.ebuild,v 1.1 2011/08/07 13:21:25 vapier Exp $

EAPI="2"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://git.openezx.org/dfu-util.git"
	inherit autotools git
	SRC_URI=""
	#KEYWORDS=""
else
	SRC_URI="http://dfu-util.gnumonks.org/releases/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="implements the Host (PC) side of the USB DFU (Device Firmware Upgrade) protocol"
HOMEPAGE="http://wiki.openmoko.org/wiki/Dfu-util"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/libusb:1"
RDEPEND="${DEPEND}"

src_prepare() {
	if [[ ${PV} == "9999" ]] ; then
		git_src_prepare
		eautoreconf
	fi
	sed -i '/^bin_PROGRAMS/s:dfu-util_static[^ ]*::' src/Makefile.in
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog README TODO
}
