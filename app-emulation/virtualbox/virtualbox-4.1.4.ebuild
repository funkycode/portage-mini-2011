# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virtualbox/virtualbox-4.1.4.ebuild,v 1.6 2011/12/27 21:53:21 polynomial-c Exp $

EAPI=4

inherit eutils fdo-mime flag-o-matic linux-info pax-utils python qt4-r2 toolchain-funcs java-pkg-opt-2

if [[ ${PV} == "9999" ]] ; then
	# XXX: should finish merging the -9999 ebuild into this one ...
	ESVN_REPO_URI="http://www.virtualbox.org/svn/vbox/trunk"
	inherit linux-mod subversion
else
	MY_P=VirtualBox-${PV}
	SRC_URI="http://download.virtualbox.org/virtualbox/${PV}/${MY_P}.tar.bz2"
	S="${WORKDIR}/${MY_P}_OSE"
fi

DESCRIPTION="Family of powerful x86 virtualization products for enterprise as well as home use"
HOMEPAGE="http://www.virtualbox.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+additions alsa doc extensions headless java pam pulseaudio +opengl python +qt4 +sdk vboxwebsrv vnc"

RDEPEND="!app-emulation/virtualbox-bin
	~app-emulation/virtualbox-modules-${PV}
	dev-libs/libIDL
	>=dev-libs/libxslt-1.1.19
	net-misc/curl
	dev-libs/openssl
	dev-libs/libxml2
	sys-libs/zlib
	!headless? (
		qt4? (
			x11-libs/qt-gui:4
			x11-libs/qt-core:4
			opengl? ( x11-libs/qt-opengl:4 )
			x11-libs/libXinerama
		)
		opengl? ( virtual/opengl media-libs/freeglut )
		x11-libs/libX11
		x11-libs/libXcursor
		x11-libs/libXext
		x11-libs/libXmu
		x11-libs/libXt
		media-libs/libsdl[X,video]
	)
	vnc? ( >=net-libs/libvncserver-0.9.7 )
	java? ( >=virtual/jre-1.5 )"
DEPEND="${RDEPEND}
	>=dev-util/kbuild-0.1.999
	>=dev-lang/yasm-0.6.2
	sys-devel/bin86
	sys-devel/dev86
	sys-power/iasl
	media-libs/libpng
	pam? ( sys-libs/pam )
	sys-libs/libcap
	doc? (
		dev-texlive/texlive-basic
		dev-texlive/texlive-latex
		dev-texlive/texlive-latexrecommended
		dev-texlive/texlive-latexextra
		dev-texlive/texlive-fontsrecommended
		dev-texlive/texlive-fontsextra
	)
	java? ( >=virtual/jdk-1.5 )
	dev-util/pkgconfig
	alsa? ( >=media-libs/alsa-lib-1.0.13 )
	!headless? ( x11-libs/libXinerama )
	pulseaudio? ( media-sound/pulseaudio )
	vboxwebsrv? ( >=net-libs/gsoap-2.7.13 )"
PDEPEND="additions? ( ~app-emulation/virtualbox-additions-${PV} )
	extensions? ( ~app-emulation/virtualbox-extpack-oracle-${PV} )"

QA_TEXTRELS_x86="usr/lib/virtualbox-ose/VBoxGuestPropSvc.so
	usr/lib/virtualbox/VBoxSDL.so
	usr/lib/virtualbox/VBoxSharedFolders.so
	usr/lib/virtualbox/VBoxDD2.so
	usr/lib/virtualbox/VBoxOGLrenderspu.so
	usr/lib/virtualbox/VBoxPython.so
	usr/lib/virtualbox/VBoxDD.so
	usr/lib/virtualbox/VBoxDDU.so
	usr/lib/virtualbox/VBoxREM64.so
	usr/lib/virtualbox/VBoxSharedClipboard.so
	usr/lib/virtualbox/VBoxHeadless.so
	usr/lib/virtualbox/VBoxRT.so
	usr/lib/virtualbox/VBoxREM.so
	usr/lib/virtualbox/VBoxSettings.so
	usr/lib/virtualbox/VBoxKeyboard.so
	usr/lib/virtualbox/VBoxSharedCrOpenGL.so
	usr/lib/virtualbox/VBoxVMM.so
	usr/lib/virtualbox/VirtualBox.so
	usr/lib/virtualbox/VBoxOGLhosterrorspu.so
	usr/lib/virtualbox/components/VBoxC.so
	usr/lib/virtualbox/components/VBoxSVCM.so
	usr/lib/virtualbox/components/VBoxDDU.so
	usr/lib/virtualbox/components/VBoxRT.so
	usr/lib/virtualbox/components/VBoxREM.so
	usr/lib/virtualbox/components/VBoxVMM.so
	usr/lib/virtualbox/VBoxREM32.so
	usr/lib/virtualbox/VBoxPython2_4.so
	usr/lib/virtualbox/VBoxPython2_5.so
	usr/lib/virtualbox/VBoxPython2_6.so
	usr/lib/virtualbox/VBoxPython2_7.so
	usr/lib/virtualbox/VBoxXPCOMC.so
	usr/lib/virtualbox/VBoxOGLhostcrutil.so
	usr/lib/virtualbox/VBoxNetDHCP.so"

REQUIRED_USE="
	java? ( sdk )
	python? ( sdk )
	vboxwebsrv? ( java )
"

pkg_setup() {
	if built_with_use sys-devel/gcc hardened && gcc-config -c | grep -qv -E "hardenednopie|vanilla"; then
		eerror "The PIE feature provided by the \"hardened\" compiler is incompatible with ${PF}."
		eerror "You must use gcc-config to select a profile without this feature.  You may"
		eerror "choose either \"hardenednopie\", \"hardenednopiessp\" or \"vanilla\" profile;"
		eerror "however, \"hardenednopie\" is preferred because it gives the most hardening."
		eerror "Remember to run \"source /etc/profile\" before continuing.  See bug #339914."
		die
	fi

	if ! use headless && ! use qt4 ; then
		einfo "No USE=\"qt4\" selected, this build will not include"
		einfo "any Qt frontend."
	elif use headless && use qt4 ; then
		einfo "You selected USE=\"headless qt4\", defaulting to"
		einfo "USE=\"headless\", this build will not include any X11/Qt frontend."
	fi

	if ! use opengl ; then
		einfo "No USE=\"opengl\" selected, this build will lack"
		einfo "the OpenGL feature."
	fi
	java-pkg-opt-2_pkg_setup
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# Remove shipped binaries (kBuild,yasm), see bug #232775
	rm -rf kBuild/bin tools

	# Disable things unused or split into separate ebuilds
	sed -e "s/MY_LIBDIR/$(get_libdir)/" \
		"${FILESDIR}"/${PN}-4-localconfig > LocalConfig.kmk || die

	# unset useless/problematic checks in configure
	epatch "${FILESDIR}/${PN}-ose-3.2.8-mesa-check.patch" \
		"${FILESDIR}/${PN}-4-makeself-check.patch" \
		"${FILESDIR}/${PN}-4-mkisofs-check.patch"

	# fix build with --as-needed (bug #249295 and bug #350907)
	epatch "${FILESDIR}/${PN}-4.1.4-asneeded.patch"

	# Respect LDFLAGS
	sed -e "s/_LDFLAGS\.${ARCH}*.*=/& ${LDFLAGS}/g" \
		-i Config.kmk src/libs/xpcom18a4/Config.kmk || die

	# We still want to use ${HOME}/.VirtualBox/Machines as machines dir.
	epatch "${FILESDIR}/${PN}-4.0.2-restore_old_machines_dir.patch"

	# Don't build vboxpci.ko module (D'oh!)
	epatch "${FILESDIR}"/${PN}-4.1.2-vboxpci-build.patch

	# Fixed compilation with yasm-1.2.0 (bug #391189)
	epatch "${FILESDIR}"/${PN}-4.1.6-yasm120-fix.patch

	# Use PAM only when pam USE flag is enbaled (bug #376531)
	if ! use pam ; then
		elog "Disabling PAM removes the possibility to use the VRDP features."
		sed -i 's/^.*VBOX_WITH_PAM/#VBOX_WITH_PAM/' Config.kmk || die
		sed -i 's;\(.*/auth/Makefile.kmk.*\);#\1;' \
			src/VBox/HostServices/Makefile.kmk || die
	fi

	# add correct java path
	if use java ; then
		sed "s:/usr/lib/jvm/java-6-sun:$(java-config -O):" \
			-i "${S}"/Config.kmk || die
		java-pkg-opt-2_src_prepare
	fi
}

src_configure() {
	local myconf
	use alsa       || myconf+=" --disable-alsa"
	use opengl     || myconf+=" --disable-opengl"
	use pulseaudio || myconf+=" --disable-pulse"
	use python     || myconf+=" --disable-python"
	use java       || myconf+=" --disable-java"
	use vboxwebsrv && myconf+=" --enable-webservice"
	use vnc        && myconf+=" --enable-vnc"
	use doc        || myconf+=" --disable-docs"
	if ! use headless ; then
		use qt4 || myconf+=" --disable-qt4"
	else
		myconf+=" --build-headless --disable-opengl"
	fi
	# not an autoconf script
	./configure \
		--with-gcc="$(tc-getCC)" \
		--with-g++="$(tc-getCXX)" \
		--disable-kmods \
		--disable-dbus \
		${myconf} \
		|| die "configure failed"
}

src_compile() {
	source ./env.sh

	# Force kBuild to respect C[XX]FLAGS and MAKEOPTS (bug #178529)
	# and strip all flags
	# strip-flags

	MAKE="kmk" emake \
		VBOX_VERSION_STRING='$(VBOX_VERSION_MAJOR).$(VBOX_VERSION_MINOR).$(VBOX_VERSION_BUILD)'-Gentoo_ \
		TOOL_GCC3_CC="$(tc-getCC)" TOOL_GCC3_CXX="$(tc-getCXX)" \
		TOOL_GCC3_AS="$(tc-getCC)" TOOL_GCC3_AR="$(tc-getAR)" \
		TOOL_GCC3_LD="$(tc-getCXX)" TOOL_GCC3_LD_SYSMOD="$(tc-getLD)" \
		TOOL_GCC3_CFLAGS="${CFLAGS}" TOOL_GCC3_CXXFLAGS="${CXXFLAGS}" \
		VBOX_GCC_OPT="${CXXFLAGS}" \
		TOOL_YASM_AS=yasm KBUILD_PATH="${S}/kBuild" \
		all || die "kmk failed"
}

src_install() {
	cd "${S}"/out/linux.${ARCH}/release/bin || die

	# Create configuration files
	insinto /etc/vbox
	newins "${FILESDIR}/${PN}-4-config" vbox.cfg

	# Set the right libdir
	sed -i \
		-e "s/MY_LIBDIR/$(get_libdir)/" \
		"${D}"/etc/vbox/vbox.cfg || die "vbox.cfg sed failed"

	# Symlink binaries to the shipped wrapper
	exeinto /usr/$(get_libdir)/${PN}
	newexe "${FILESDIR}/${PN}-ose-3-wrapper" "VBox" || die
	fowners root:vboxusers /usr/$(get_libdir)/${PN}/VBox
	fperms 0750 /usr/$(get_libdir)/${PN}/VBox

	dosym /usr/$(get_libdir)/${PN}/VBox /usr/bin/VBoxManage
	dosym /usr/$(get_libdir)/${PN}/VBox /usr/bin/VBoxVRDP
	dosym /usr/$(get_libdir)/${PN}/VBox /usr/bin/VBoxHeadless
	dosym /usr/$(get_libdir)/${PN}/VBoxTunctl /usr/bin/VBoxTunctl

	# Install binaries and libraries
	insinto /usr/$(get_libdir)/${PN}
	doins -r components || die

	if use sdk ; then
		doins -r sdk || die
	fi

	if use vboxwebsrv ; then
		doins vboxwebsrv || die
		fowners root:vboxusers /usr/$(get_libdir)/${PN}/vboxwebsrv
		fperms 0750 /usr/$(get_libdir)/${PN}/vboxwebsrv
		dosym /usr/$(get_libdir)/${PN}/VBox /usr/bin/vboxwebsrv
		newinitd "${FILESDIR}"/vboxwebsrv-initd vboxwebsrv
		newconfd "${FILESDIR}"/vboxwebsrv-confd vboxwebsrv
	fi

	for each in VBox{Manage,SVC,XPCOMIPCD,Tunctl,NetAdpCtl,NetDHCP,ExtPackHelperApp} *so *r0 *gc ; do
		doins $each || die
		fowners root:vboxusers /usr/$(get_libdir)/${PN}/${each}
		fperms 0750 /usr/$(get_libdir)/${PN}/${each}
	done
	# VBoxNetAdpCtl and VBoxNetDHCP binaries need to be suid root in any case..
	fperms 4750 /usr/$(get_libdir)/${PN}/VBoxNetAdpCtl
	fperms 4750 /usr/$(get_libdir)/${PN}/VBoxNetDHCP

	if ! use headless ; then
		for each in VBox{SDL,Headless} ; do
			doins $each || die
			fowners root:vboxusers /usr/$(get_libdir)/${PN}/${each}
			fperms 4750 /usr/$(get_libdir)/${PN}/${each}
			pax-mark -m "${D}"/usr/$(get_libdir)/${PN}/${each}
		done

		if use opengl && use qt4 ; then
			doins VBoxTestOGL || die
			fowners root:vboxusers /usr/$(get_libdir)/${PN}/VBoxTestOGL
			fperms 0750 /usr/$(get_libdir)/${PN}/VBoxTestOGL
		fi

		dosym /usr/$(get_libdir)/${PN}/VBox /usr/bin/VBoxSDL

		if use qt4 ; then
			doins VirtualBox || die
			fowners root:vboxusers /usr/$(get_libdir)/${PN}/VirtualBox
			fperms 4750 /usr/$(get_libdir)/${PN}/VirtualBox
			pax-mark -m "${D}"/usr/$(get_libdir)/${PN}/VirtualBox

			dosym /usr/$(get_libdir)/${PN}/VBox /usr/bin/VirtualBox

			newmenu "${FILESDIR}"/${PN}-ose.desktop-2 ${PN}.desktop
		fi

		newicon	"${S}"/src/VBox/Frontends/VirtualBox/images/OSE/VirtualBox_32px.png ${PN}.png
	else
		doins VBoxHeadless || die
		fowners root:vboxusers /usr/$(get_libdir)/${PN}/VBoxHeadless
		fperms 4750 /usr/$(get_libdir)/${PN}/VBoxHeadless
		pax-mark -m "${D}"/usr/$(get_libdir)/${PN}/VBoxHeadless
	fi

	# Install EFI Firmware files (bug #320757)
	pushd "${S}"/src/VBox/Devices/EFI/FirmwareBin &>/dev/null || die
	for fwfile in VBoxEFI{32,64}.fd ; do
		doins ${fwfile} || die
		fowners root:vboxusers /usr/$(get_libdir)/${PN}/${fwfile} || die
	done
	popd &>/dev/null || die

	# New way of handling USB device nodes for VBox (bug #356215)
	insinto /lib/udev
	doins VBoxCreateUSBNode.sh
	fowners root:vboxusers /lib/udev/VBoxCreateUSBNode.sh
	fperms 0750 /lib/udev/VBoxCreateUSBNode.sh
	insinto /lib/udev/rules.d
	doins "${FILESDIR}"/10-virtualbox.rules

	insinto /usr/share/${PN}
	if ! use headless && use qt4 ; then
		doins -r nls
	fi

	# VRDPAuth only works with this (bug #351949)
	dosym VBoxAuth.so  /usr/$(get_libdir)/${PN}/VRDPAuth.so

	# set an env-variable for 3rd party tools
	echo -n "VBOX_APP_HOME=/usr/$(get_libdir)/${PN}" > "${T}/90virtualbox"
	doenvd "${T}/90virtualbox"

	if use java ; then
		java-pkg_regjar "${D}/usr/$(get_libdir)/${PN}/sdk/bindings/xpcom/java/vboxjxpcom.jar"
		java-pkg_regso "${D}/usr/$(get_libdir)/${PN}/libvboxjxpcom.so"
	fi
}

pkg_postinst() {
	fdo-mime_desktop_database_update

	udevadm control --reload-rules && udevadm trigger --subsystem-match=usb

	if ! use headless && use qt4 ; then
		elog "To launch VirtualBox just type: \"VirtualBox\"."
	fi
	elog "You must be in the vboxusers group to use VirtualBox."
	elog ""
	elog "The latest user manual is available for download at:"
	elog "http://download.virtualbox.org/virtualbox/${PV}/UserManual.pdf"
	elog ""
	elog "For advanced networking setups you should emerge:"
	elog "net-misc/bridge-utils and sys-apps/usermode-utilities"
	elog ""
	elog "IMPORTANT!"
	elog "If you upgrade from app-emulation/virtualbox-ose make sure to run"
	elog "\"env-update\" as root and logout and relogin as the user you wish"
	elog "to run ${PN} as."
	elog ""
	elog "Starting with version 4.0.0, ${PN} has USB-1 support."
	elog "For USB-2 support, PXE-boot ability and VRDP support please emerge"
	elog "  app-emulation/virtualbox-extpack-oracle"
	elog "package."
	if [ -e "${ROOT}/etc/udev/rules.d/10-virtualbox.rules" ] ; then
		elog ""
		elog "Please remove \"${ROOT}/etc/udev/rules.d/10-virtualbox.rules\""
		elog "or else USB in ${PN} won't work."
	fi
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
