# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usb_modeswitch/usb_modeswitch-1.2.3.ebuild,v 1.3 2012/03/22 07:15:22 ssuominen Exp $

EAPI=4
inherit linux-info toolchain-funcs

MY_PN=${PN/_/-}
MY_P=${MY_PN}-${PV}
DATA_VER=20120120

DESCRIPTION="USB_ModeSwitch is a tool for controlling 'flip flop' (multiple devices) USB gear like UMTS sticks"
HOMEPAGE="http://www.draisberghof.de/usb_modeswitch/ http://www.draisberghof.de/usb_modeswitch/device_reference.txt"
SRC_URI="http://www.draisberghof.de/${PN}/${MY_P}.tar.bz2
	http://www.draisberghof.de/${PN}/${MY_PN}-data-${DATA_VER}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="virtual/libusb:0"
RDEPEND="${DEPEND}
	dev-lang/tcl" # usb_modeswitch script is tcl

S=${WORKDIR}/${MY_P}

CONFIG_CHECK="~USB_SERIAL"

src_prepare() {
	sed -i -e '/install.*BIN/s:-s::' Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc ChangeLog README

	pushd ../${MY_PN}-data-${DATA_VER} >/dev/null
	emake DESTDIR="${D}" files-install db-install
	docinto data
	dodoc ChangeLog README
	popd >/dev/null
}
