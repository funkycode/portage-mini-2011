# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-intel/xf86-video-intel-2.17.0-r3.ebuild,v 1.4 2012/02/19 15:10:26 armin76 Exp $

EAPI=4

XORG_DRI=dri
inherit linux-info xorg-2

DESCRIPTION="X.Org driver for Intel cards"

KEYWORDS="amd64 ia64 x86 -x86-fbsd"
IUSE="sna"

RDEPEND="x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXvMC
	>=x11-libs/libxcb-1.5
	>=x11-libs/libdrm-2.4.23[video_cards_intel]
	sna? (
		>=x11-base/xorg-server-1.10
		>=x11-libs/pixman-0.23
	)"
# Requires dri2proto-2.6 (unreleased)
DEPEND="${RDEPEND}
	>=x11-proto/dri2proto-2.6"

PATCHES=(
	"${FILESDIR}"/${PN}-2.17-sna-offsets.patch
	"${FILESDIR}"/${PN}-2.17-sna-pipeline-flush.patch
)

pkg_setup() {
	xorg-2_pkg_setup
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable dri)
		$(use_enable sna)
		--enable-xvmc
	)
}

pkg_postinst() {
	if linux_config_exists \
		&& ! linux_chkconfig_present DRM_I915_KMS; then
		echo
		ewarn "This driver requires KMS support in your kernel"
		ewarn "  Device Drivers --->"
		ewarn "    Graphics support --->"
		ewarn "      Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)  --->"
		ewarn "      <*>   Intel 830M, 845G, 852GM, 855GM, 865G (i915 driver)  --->"
		ewarn "              i915 driver"
		ewarn "      [*]       Enable modesetting on intel by default"
		echo
	fi
}
