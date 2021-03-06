# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/nvidiabl/nvidiabl-0.72.ebuild,v 1.1 2011/11/11 16:38:50 angelos Exp $

EAPI=4
inherit linux-mod

DESCRIPTION="Linux driver for setting the backlight brightness on laptops using
NVIDIA GPU"
HOMEPAGE="https://github.com/guillaumezin/nvidiabl"
SRC_URI="https://github.com/downloads/guillaumezin/${PN}/${P}-source-only.dkms.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

BUILD_TARGETS="modules"
MODULE_NAMES="nvidiabl()"

S=${WORKDIR}/dkms_source_tree

pkg_pretend() {
	CONFIG_CHECK="FB_BACKLIGHT"
	linux-mod_pkg_setup
}

src_compile() {
	BUILD_PARAMS="KVER=${KV_FULL}"
	linux-mod_src_compile
}
