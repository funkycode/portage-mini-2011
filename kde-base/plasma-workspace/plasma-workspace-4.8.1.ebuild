# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/plasma-workspace/plasma-workspace-4.8.1.ebuild,v 1.3 2012/04/04 19:19:57 ago Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kde-workspace"
KMMODULE="plasma"
PYTHON_DEPEND="python? 2"
inherit python kde4-meta

DESCRIPTION="Plasma: KDE desktop framework"
KEYWORDS="amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE="debug google-gadgets gps python qalculate +rss semantic-desktop xinerama"

COMMONDEPEND="
	$(add_kdebase_dep kactivities)
	$(add_kdebase_dep kdelibs 'semantic-desktop=')
	$(add_kdebase_dep kephal)
	$(add_kdebase_dep ksysguard)
	$(add_kdebase_dep libkworkspace)
	$(add_kdebase_dep libplasmagenericshell)
	$(add_kdebase_dep libtaskmanager)
	$(add_kdebase_dep solid)
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libXrender
	google-gadgets? ( >=x11-misc/google-gadgets-0.11.0[qt4] )
	gps? ( >=sci-geosciences/gpsd-2.37 )
	python? (
		>=dev-python/PyQt4-4.4.0[X]
		>=dev-python/sip-4.7.1
		$(add_kdebase_dep pykde4)
	)
	qalculate? ( sci-libs/libqalculate )
	rss? (
		$(add_kdebase_dep kdepimlibs 'semantic-desktop=')
		$(add_kdebase_dep libplasmaclock 'holidays')
	)
	!rss? ( $(add_kdebase_dep libplasmaclock '-holidays') )
	xinerama? ( x11-libs/libXinerama )
"
DEPEND="${COMMONDEPEND}
	rss? ( dev-libs/boost )
	x11-proto/compositeproto
	x11-proto/damageproto
	x11-proto/fixesproto
	x11-proto/renderproto
	xinerama? ( x11-proto/xineramaproto )
"
RDEPEND="${COMMONDEPEND}
	$(add_kdebase_dep plasma-runtime)
"

KMEXTRA="
	statusnotifierwatcher/
"
KMEXTRACTONLY="
	krunner/dbus/org.freedesktop.ScreenSaver.xml
	krunner/dbus/org.kde.krunner.App.xml
	ksmserver/org.kde.KSMServerInterface.xml
	libs/kephal/
	libs/kworkspace/
	libs/taskmanager/
	libs/plasmagenericshell/
	libs/ksysguard/
	ksysguard/
"

KMLOADLIBS="libkworkspace libplasmaclock libplasmagenericshell libtaskmanager"

PATCHES=(
	"${FILESDIR}/${PN}-4.4.2-xinerama_cmake_automagic.patch"
)

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
	kde4-meta_pkg_setup
}

src_unpack() {
	if use handbook; then
		KMEXTRA+=" doc/plasma-desktop"
	fi

	kde4-meta_src_unpack
}

src_prepare() {
	sed -i -e '1ifind_package(KdepimLibs)' plasma/CMakeLists.txt || die

	kde4-meta_src_prepare
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with google-gadgets Googlegadgets)
		$(cmake-utils_use_with gps libgps)
		$(cmake-utils_use_with python SIP)
		$(cmake-utils_use_with python PyQt4)
		$(cmake-utils_use_with python PyKDE4)
		$(cmake-utils_use_with qalculate)
		$(cmake-utils_use_with rss KdepimLibs)
		$(cmake-utils_use_with semantic-desktop Akonadi)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_with xinerama X11_Xinerama)
		-DWITH_Xmms=OFF
	)

	kde4-meta_src_configure
}

src_install() {
	kde4-meta_src_install

	rm -f \
		"${ED}$(python_get_sitedir)"/PyKDE4/*.py[co] \
		"${ED}"/usr/share/apps/plasma_scriptengine_python/*.py[co]
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	if use python; then
		python_mod_optimize \
			PyKDE4 \
			/usr/share/apps/plasma_scriptengine_python
	fi
}

pkg_postrm() {
	kde4-meta_pkg_postrm

	if [[ -d ${EPREFIX}/usr/share/apps/plasma_scriptengine_python ]]; then
		python_mod_cleanup \
			PyKDE4 \
			/usr/share/apps/plasma_scriptengine_python
	fi
}
