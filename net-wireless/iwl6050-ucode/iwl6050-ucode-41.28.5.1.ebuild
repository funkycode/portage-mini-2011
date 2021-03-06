# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/iwl6050-ucode/iwl6050-ucode-41.28.5.1.ebuild,v 1.4 2012/02/16 19:20:47 phajdan.jr Exp $

inherit linux-info

MY_PN="iwlwifi-6050-ucode"

DESCRIPTION="Intel (R) Wireless WiFi Link 6250-AGN ucode"
HOMEPAGE="http://intellinuxwireless.org/?p=iwlwifi"
SRC_URI="http://intellinuxwireless.org/iwlwifi/downloads/${MY_PN}-${PV}.tgz"

LICENSE="ipw3945"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RDEPEND=""

DEPEND="|| ( >=sys-fs/udev-096 >=sys-apps/hotplug-20040923 )"

S="${WORKDIR}/${MY_PN}-${PV}"

src_compile() { :; }

src_install() {
	insinto /lib/firmware
	doins "${S}/iwlwifi-6050-5.ucode" || die

	dodoc README* || die "dodoc failed"

	if kernel_is lt 2 6 37; then
	echo
		ewarn "Your kernel version is ${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}"
		ewarn "This microcode image requires a kernel >= 2.6.37 or a 2.6.36 "
		ewarn "kernel using >= genpatches-2.6.36-8 which is included"
		ewarn "in gentoo-sources >= 2.6.36-r6 or any kernel version >= 2.6.37."
	fi
}
