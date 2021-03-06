# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/kvirc/kvirc-4.2_pre5816.ebuild,v 1.4 2012/02/04 09:57:10 hwoarang Exp $

EAPI="4"
PYTHON_DEPEND="python? 2"

inherit cmake-utils multilib python

DESCRIPTION="Advanced IRC Client"
HOMEPAGE="http://www.kvirc.net/"
SRC_URI="mirror://gentoo/${P}.tar.xz"

LICENSE="kvirc"
SLOT="4"
KEYWORDS="~alpha amd64 ~ppc ~ppc64 x86"
IUSE="audiofile dcc_video +dcc_voice debug doc gsm +ipc ipv6 kde +nls oss +perl +phonon profile +python +qt-dbus qt-webkit +ssl theora +transparency"

RDEPEND=">=dev-libs/crypto++-5.6.0-r1
	sys-libs/zlib
	x11-libs/libX11
	>=x11-libs/qt-core-4.6
	>=x11-libs/qt-gui-4.6
	>=x11-libs/qt-sql-4.6
	dcc_video? (
		media-libs/libv4l
		theora? ( media-libs/libogg media-libs/libtheora )
	)
	kde? ( >=kde-base/kdelibs-4 )
	oss? ( audiofile? ( media-libs/audiofile ) )
	perl? ( dev-lang/perl )
	phonon? ( || ( media-libs/phonon >=x11-libs/qt-phonon-4.6 ) )
	qt-dbus? ( >=x11-libs/qt-dbus-4.6 )
	qt-webkit? ( >=x11-libs/qt-webkit-4.6 )
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6.4
	dev-util/pkgconfig
	x11-proto/scrnsaverproto
	nls? ( sys-devel/gettext )
	doc? ( app-doc/doxygen )"
RDEPEND="${RDEPEND}
	gsm? ( media-sound/gsm )"

DOCS="ChangeLog doc/FAQ"

REQUIRED_USE="audiofile? ( oss ) theora? ( dcc_video )"

pkg_setup() {
	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	VERSIO_PRAESENS="${PV#*_pre}"
	einfo "Setting of revision number to ${VERSIO_PRAESENS}"
	sed -e "/#define KVI_DEFAULT_FRAME_CAPTION/s/KVI_VERSION/& \" r${VERSIO_PRAESENS}\"/" -i src/kvirc/ui/KviMainWindow.cpp || die "Setting of revision number failed"
}

src_configure() {
	local libdir="$(get_libdir)"
	local mycmakeargs=(
		-DLIB_SUFFIX=${libdir#lib}
		-DMANUAL_REVISION=${VERSIO_PRAESENS}
		-DWANT_COEXISTENCE=1
		-DWANT_CRYPT=1
		-DWANT_CRYPTOPP=1
		-DWANT_ENV_FLAGS=1
		-DWANT_VERBOSE=1
		$(cmake-utils_use_want audiofile AUDIOFILE)
		$(cmake-utils_use_want dcc_video DCC_VIDEO)
		$(cmake-utils_use_want dcc_voice DCC_VOICE)
		$(cmake-utils_use_want debug DEBUG)
		$(cmake-utils_use_want doc DOXYGEN)
		$(cmake-utils_use_want gsm GSM)
		$(cmake-utils_use_want ipc IPC)
		$(cmake-utils_use_want ipv6 IPV6)
		$(cmake-utils_use_want kde KDE4)
		$(cmake-utils_use_want nls GETTEXT)
		$(cmake-utils_use_want oss OSS)
		$(cmake-utils_use_want perl PERL)
		$(cmake-utils_use_want phonon PHONON)
		$(cmake-utils_use_want profile MEMORY_PROFILE)
		$(cmake-utils_use_want python PYTHON)
		$(cmake-utils_use_want qt-dbus QTDBUS)
		$(cmake-utils_use_want qt-webkit QTWEBKIT)
		$(cmake-utils_use_want ssl OPENSSL)
		$(cmake-utils_use_want theora OGG_THEORA)
		$(cmake-utils_use_want transparency TRANSPARENCY)
	)

	cmake-utils_src_configure
}
