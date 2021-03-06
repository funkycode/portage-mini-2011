# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/google-chrome/google-chrome-20.0.1096.1_alpha131343.ebuild,v 1.1 2012/04/12 02:14:56 floppym Exp $

EAPI="4"

CHROMIUM_LANGS="am ar bg bn ca cs da de el en_GB es es_LA et fa fi fil fr gu he
	hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt_BR pt_PT ro ru sk sl sr
	sv sw ta te th tr uk vi zh_CN zh_TW"

inherit chromium eutils multilib pax-utils unpacker

DESCRIPTION="The web browser from Google"
HOMEPAGE="http://www.google.com/chrome"

case ${PV} in
	*_alpha*)
		SLOT="unstable"
		MY_PV=${PV/_alpha/-r}
		;;
	*_beta*)
		SLOT="beta"
		MY_PV=${PV/_beta/-r}
		;;
	*_p*)
		SLOT="stable"
		MY_PV=${PV/_p/-r}
		;;
	*)
		die "Invalid value for \${PV}: ${PV}"
		;;
esac

MY_PN="${PN}-${SLOT}"
MY_P="${MY_PN}_${MY_PV}"

SRC_BASE="http://dl.google.com/linux/chrome/deb/pool/main/g/${MY_PN}/${MY_P}_"
SRC_URI="amd64? ( ${SRC_BASE}amd64.deb ) x86? ( ${SRC_BASE}i386.deb )"

LICENSE="google-chrome"
KEYWORDS="-* ~amd64 ~x86"
IUSE="+plugins"
RESTRICT="mirror strip"

RDEPEND="
	media-libs/alsa-lib
	app-arch/bzip2
	x11-libs/cairo
	net-print/cups
	sys-apps/dbus
	dev-libs/expat
	media-libs/fontconfig
	media-libs/freetype
	app-misc/ca-certificates
	gnome-base/gconf:2
	dev-libs/libgcrypt
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	x11-libs/pango
	media-libs/libpng:1.2
	|| ( >=sys-devel/gcc-4.4.0[-nocxx] >=sys-devel/gcc-4.4.0[cxx] )
	sys-fs/udev
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXScrnSaver
	sys-libs/zlib
	x11-misc/xdg-utils
	net-misc/curl
	dev-libs/openssl:0.9.8
"

# Add blockers for the other slots.
for x in 0 beta stable unstable; do
	if [[ ${SLOT} != ${x} ]]; then
		RDEPEND+=" !${CATEGORY}/${PN}:${x}"
	fi
done

QA_PREBUILT="*"
S=${WORKDIR}

src_install() {
	CHROME_HOME="opt/google/chrome/"

	pax-mark m ${CHROME_HOME}chrome || die
	rm -rf usr/share/menu || die
	mv usr/share/doc/${PN} usr/share/doc/${PF} || die

	pushd "${CHROME_HOME}locales" > /dev/null || die
	chromium_remove_language_paks
	popd

	mv opt usr "${D}" || die

	fperms u+s "/${CHROME_HOME}chrome-sandbox" || die

	if use plugins ; then
		local args='"$@"'
		local plugins="/usr/$(get_libdir)/nsbrowser/plugins"
		sed -e "s:${args}:--extra-plugin-dir=\"${plugins}\" \\0:" \
			-i "${D}${CHROME_HOME}google-chrome" || die
	fi

	domenu "${D}${CHROME_HOME}google-chrome.desktop" || die
	local size
	for size in 16 22 24 32 48 64 128 256 ; do
		insinto /usr/share/icons/hicolor/${size}x${size}/apps
		newins "${D}${CHROME_HOME}product_logo_${size}.png" google-chrome.png
	done
}
