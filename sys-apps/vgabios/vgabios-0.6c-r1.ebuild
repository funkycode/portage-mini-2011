# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/vgabios/vgabios-0.6c-r1.ebuild,v 1.3 2012/03/16 16:11:55 tomka Exp $

# Can't really call them backports when they're fixes that upstream
# won't carry
FIXES=2

EAPI=4

inherit eutils

DESCRIPTION="VGA BIOS implementation"
HOMEPAGE="http://www.nongnu.org/vgabios/"
SRC_URI="http://savannah.gnu.org/download/${PN}/${P}.tgz
		http://dev.gentoo.org/~cardoe/distfiles/${P}-fixes-${FIXES}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

DEPEND="sys-devel/dev86"
RDEPEND="!app-emulation/qemu
		!<=app-emulation/qemu-kvm-1.0"

src_prepare() {
	EPATCH_FORCE=yes EPATCH_SUFFIX="patch" EPATCH_SOURCE="${S}/patches" \
		epatch
}

pkg_configure() {
	:
}

src_compile() {
	emake clean # Necessary to clean up the pre-built pieces
	emake biossums
	emake
}

src_install() {
	insinto /usr/share/vgabios

	# Stock VGABIOS
	newins VGABIOS-lgpl-latest.bin vgabios.bin
	use debug && newins VGABIOS-lgpl-latest.debug.bin vgabios.debug.bin

	# Cirrus
	newins VGABIOS-lgpl-latest.cirrus.bin vgabios-cirrus.bin
	use debug && newins VGABIOS-lgpl-latest.cirrus.debug.bin \
		vgabios-cirrus.debug.bin

	# QXL
	newins VGABIOS-lgpl-latest.qxl.bin vgabios-qxl.bin
	use debug && newins VGABIOS-lgpl-latest.qxl.debug.bin vgabios-qxl.debug.bin

	# Standard VGA
	newins VGABIOS-lgpl-latest.stdvga.bin vgabios-stdvga.bin
	use debug && newins VGABIOS-lgpl-latest.stdvga.debug.bin \
		vgabios-stdvga.debug.bin

	# VMWare
	newins VGABIOS-lgpl-latest.vmware.bin vgabios-vmware.bin
	use debug && newins VGABIOS-lgpl-latest.vmware.debug.bin \
		vgabios-vmware.debug.bin
}
