# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-firmware/linux-firmware-20120125.ebuild,v 1.5 2012/03/24 17:34:07 phajdan.jr Exp $

EAPI=4
inherit savedconfig

if [[ ${PV} == 99999999* ]]; then
	inherit git-2
	SRC_URI=""
	EGIT_REPO_URI="git://git.kernel.org/pub/scm/linux/kernel/git/firmware/${PN}.git"
else
	SRC_URI="mirror://gentoo/${P}.tar.gz"
fi

DESCRIPTION="Linux firmware files"
HOMEPAGE="http://git.kernel.org/?p=linux/kernel/git/firmware/linux-firmware.git"

LICENSE="GPL-1 GPL-2 GPL-3 BSD freedist"
KEYWORDS="amd64 arm x86"
SLOT="0"
IUSE="savedconfig"

DEPEND=""
RDEPEND="!savedconfig? (
		!media-sound/alsa-firmware[alsa_cards_korg1212]
		!media-sound/alsa-firmware[alsa_cards_maestro3]
		!media-sound/alsa-firmware[alsa_cards_sb16]
		!media-sound/alsa-firmware[alsa_cards_ymfpci]
		!media-tv/cx18-firmware
		!media-tv/ivtv-firmware
		!media-tv/linuxtv-dvb-firmware[dvb_cards_cx231xx]
		!media-tv/linuxtv-dvb-firmware[dvb_cards_cx23885]
		!media-tv/linuxtv-dvb-firmware[dvb_cards_usb-dib0700]
		!net-dialup/ueagle-atm
		!net-dialup/ueagle4-atm
		!net-wireless/ar9271-firmware
		!net-wireless/i2400m-fw
		!net-wireless/iwl1000-ucode
		!net-wireless/iwl3945-ucode
		!net-wireless/iwl4965-ucode
		!net-wireless/iwl5000-ucode
		!net-wireless/iwl5150-ucode
		!net-wireless/iwl6000-ucode
		!net-wireless/iwl6005-ucode
		!net-wireless/iwl6030-ucode
		!net-wireless/iwl6050-ucode
		!net-wireless/libertas-firmware
		!net-wireless/rt61-firmware
		!net-wireless/rt73-firmware
		!net-wireless/rt2860-firmware
		!net-wireless/rt2870-firmware
		!sys-block/qla-fc-firmware
		!x11-drivers/radeon-ucode
	)"
#add anything else that collides to this

src_unpack() {
	if [[ ${PV} == 99999999* ]]; then
		git-2_src_unpack
	else
		default
		# rename directory from git snapshot tarball
		mv ${PN}-*/ ${P} || die
	fi
}

src_prepare() {
	echo "# Remove files that shall not be installed from this list." > ${PN}.conf
	find * \( \! -type d -and \! -name ${PN}.conf \) >> ${PN}.conf

	if use savedconfig; then
		restore_config ${PN}.conf
		ebegin "Removing all files not listed in config"
		find * \( \! -type d -and \! -name ${PN}.conf \) \
			| sort ${PN}.conf ${PN}.conf - \
			| uniq -u | xargs -r rm
		eend $? || die
		# remove empty directories, bug #396073
		find -type d -empty -delete || die
	fi
}

src_install() {
	save_config ${PN}.conf
	rm ${PN}.conf || die
	insinto /lib/firmware/
	doins -r *
}

pkg_preinst() {
	if use savedconfig; then
		ewarn "USE=savedconfig is active. You must handle file collisions manually."
	fi
}

pkg_postinst() {
	elog "If you are only interested in particular firmware files, edit the saved"
	elog "configfile and remove those that you do not want."
}
