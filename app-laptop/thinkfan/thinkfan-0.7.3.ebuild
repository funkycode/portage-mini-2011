# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="Minimalist tool to control fan using temperature. Supports sysfs hwmon interface and thinkpad_acpi"
HOMEPAGE="http://thinkfan.sourceforge.net/"
SRC_URI="mirror://sourceforge/thinkfan/${P}.tar.gz"

LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

# TODO: kernel checks

src_install() {
	dosbin thinkfan
	newinitd rcscripts/thinkfan.gentoo thinkfan

	docompress -x ${ROOT}usr/share/doc/${PF}/thinkfan.conf.{sysfs,thinkpad}
	dodoc ChangeLog NEWS README thinkfan.conf.{sysfs,thinkpad}

	elog "Sample configuration files have been placed to ${ROOT}usr/share/doc/${PF}/"
	elog
	if [ -f /proc/acpi/ibm/thermal ]; then
		elog "You seem to be running ThinkPad with thermal interface."
		elog "You can use thinkfan.conf.thinkpad as a base for your configuration."
	elif [ -f /proc/acpi/ibm/fan ]; then
		elog "You seem to be running ThinkPad without thermal interface."
		elog "You may want to specify sensors but not fan in your configuration file for"
		elog "additional safety (fan watchdog exposed in /proc/ibm/acpi/fan)"
	else  # no assumptions here, think of chroot, different kernel etc.
		elog "TODO"
	fi
	ewarn "Be sure to read README in any case, owherwise you may DESTROY your machine."
	elog
	elog "You need to enable fan_control when thinkpad_acpi module is loaded."
	elog "Create file /etc/modprobe.d/thinkfan.conf with the following contents:"
	elog "options thinkpad_acpi fan_control=1"
	elog
	elog "You may want to start thinkfan automatically during boot. Use following command:"
	elog "# rc-update add thinkfan boot"
}
