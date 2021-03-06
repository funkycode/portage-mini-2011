# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/fldigi/fldigi-3.21.36.ebuild,v 1.1 2012/01/23 06:23:37 tomjbe Exp $

EAPI=4

DESCRIPTION="Sound card based multimode software modem for Amateur Radio use"
HOMEPAGE="http://www.w1hkj.com/Fldigi.html"
SRC_URI="http://www.w1hkj.com/downloads/fldigi/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="hamlib nls portaudio pulseaudio sndfile xmlrpc"

RDEPEND="x11-libs/fltk:1[threads,xft]
	media-libs/libsamplerate
	media-libs/libpng
	x11-misc/xdg-utils
	hamlib? ( media-libs/hamlib )
	portaudio? ( >=media-libs/portaudio-19_pre20071207 )
	pulseaudio? ( media-sound/pulseaudio )
	sndfile? ( >=media-libs/libsndfile-1.0.10 )
	xmlrpc? ( || ( >=dev-libs/xmlrpc-c-1.18.02[abyss] <dev-libs/xmlrpc-c-1.18.02 )
		dev-perl/RPC-XML
		dev-perl/Term-ReadLine-Perl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig"

DOCS=( AUTHORS ChangeLog NEWS README )

src_configure() {
	econf $(use_with sndfile) \
		$(use_with portaudio) \
		$(use_with hamlib) \
		$(use_enable nls) \
		$(use_with pulseaudio) \
		$(use_with xmlrpc) \
		--without-asciidoc
}
