# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-text2skin/vdr-text2skin-1.3.2.ebuild,v 1.3 2012/04/07 19:08:48 hd_brummy Exp $

EAPI="4"

inherit vdr-plugin eutils

UPLOAD_NR=783 # changes with every version / new file :-(

DESCRIPTION="VDR text2skin PlugIn"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-text2skin"
SRC_URI="mirror://vdr-developerorg/${UPLOAD_NR}/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE="contrib doc +imagemagick imlib nls"

REQUIRED_USE="imagemagick? ( !imlib )
	imlib? ( !imagemagick )"

RDEPEND=">=media-video/vdr-1.6.0
	imagemagick? ( || ( media-gfx/imagemagick[cxx] media-gfx/graphicsmagick[cxx] ) )
	imlib? ( media-libs/imlib2 >=media-video/vdr-1.6.0[-graphtft] )"
DEPEND="${RDEPEND}
	imagemagick? ( dev-util/pkgconfig )
	imlib? ( dev-util/pkgconfig )
	nls? ( sys-devel/gettext )"

src_prepare() {
	local imagelib=

	epatch "${FILESDIR}/${P}-Makefile.patch"

	sed -i common.c -e 's#cPlugin::ConfigDirectory(PLUGIN_NAME_I18N)#"/usr/share/vdr/"PLUGIN_NAME_I18N#'

	if ! has_version ">=media-video/vdr-1.7.13"; then
		sed -i "s:-include \$(VDRDIR)/Make.global:#-include \$(VDRDIR)/Make.global:" Makefile
	fi

	if use imagemagick; then
		# Prefer imagemagick over graphicsmagick
		if has_version "media-gfx/imagemagick"; then
			imagelib="imagemagick"
		elif has_version "media-gfx/graphicsmagick"; then
			imagelib="graphicsmagick"
		fi
	elif use imlib; then
		imagelib="imlib2"
	else
		imagelib="none"
	fi
	sed -i -e "s:\(IMAGELIB[[:space:]]*=\) .*:\1 ${imagelib}:" Makefile || die

	if ! use nls; then
		sed -i -e 's:^WANT_I18N=.*:WANT_I18N=:' Makefile || die
	fi

	vdr-plugin_src_prepare

	if has_version ">=media-video/vdr-1.7.27"; then
		epatch "${FILESDIR}/vdr-1.7.27.diff"
	fi
}

src_install() {
	vdr-plugin_src_install

	keepdir "/usr/share/vdr/${VDRPLUGIN}"

	dodoc CONTRIBUTORS

	if use doc; then
		dodoc Docs/{Reference,Tutorial}.txt
	fi

	if use contrib; then
		dodoc -r contrib/
	fi
}
