# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/gnustep-make/gnustep-make-2.6.2-r1.ebuild,v 1.1 2012/04/02 20:46:24 voyageur Exp $

EAPI=4
inherit gnustep-base eutils prefix toolchain-funcs

DESCRIPTION="GNUstep Makefile Package"
HOMEPAGE="http://www.gnustep.org"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~sparc-solaris ~x86-solaris"
IUSE="libobjc2 native-exceptions"

DEPEND="${GNUSTEP_CORE_DEPEND}
	>=sys-devel/make-3.75
	libobjc2? ( gnustep-base/libobjc2
		>=sys-devel/clang-2.9 )
	!libobjc2? ( >=sys-devel/gcc-3.3[objc] )"
RDEPEND="${DEPEND}"

pkg_setup() {
	# Determine libobjc.so to use
	if use libobjc2; then
		libobjc_version=libobjc.so.4
	else
		# Test new libobjc.so.3
		$(tc-getCC) -Werror -Wl,-l:libobjc.so.3 "${FILESDIR}"/testlibobjc.m -o /dev/null 2> /dev/null \
			&& libobjc_version=libobjc.so.3 \
			|| libobjc_version=libobjc.so.2
	fi

	# For existing installations, determine if we will use another libobjc.so
	if has_version gnustep-base/gnustep-make; then
		local current_libobjc="$(awk -F: '/^OBJC_LIB_FLAG/ {print $2}' ${EPREFIX}/usr/share/GNUstep/Makefiles/config.make)"
		# Old installations did not set this explicitely
		: ${current_libobjc:=libobjc.so.2}

		if [[ ${current_libobjc} != ${libobjc_version} ]]; then
			ewarn "Warning: changed libobjc.so version!!"
			ewarn "The libobjc.so version used for gnustep-make has changed"
			ewarn "(either by the libojbc2 use-flag or a GCC upgrade)"
			ewarn "You must rebuild all gnustep packages installed."
			ewarn ""
			ewarn "To do so, please emerge gnustep-base/gnustep-updater and run:"
			ewarn "# gnustep-updater -l"
		fi
	fi

	if use libobjc2; then
		export CC=clang
	fi
}

src_prepare() {
	# Multilib-strict
	sed -e "s#/lib#/$(get_libdir)#" -i FilesystemLayouts/fhs-system || die "sed failed"
	epatch "${FILESDIR}"/${PN}-2.0.1-destdir.patch
	cp "${FILESDIR}"/gnustep-4.{csh,sh} "${T}"/
	eprefixify "${T}"/gnustep-4.{csh,sh}
}

src_configure() {
	#--enable-objc-nonfragile-abi: only working in clang for now
	econf \
		--with-layout=fhs-system \
		--with-config-file="${EPREFIX}"/etc/GNUstep/GNUstep.conf \
		--with-objc-lib-flag=-l:${libobjc_version} \
		$(use_enable libobjc2 objc-nonfragile-abi) \
		$(use_enable native-exceptions native-objc-exceptions)
}

src_compile() {
	emake
	# Prepare doc here (needed when no gnustep-make is already installed)
	if use doc ; then
		# If a gnustep-1 environment is set
		unset GNUSTEP_MAKEFILES
		pushd Documentation &> /dev/null
		emake all install
		popd &> /dev/null
	fi
}

src_install() {
	# Get GNUSTEP_* variables
	. ./GNUstep.conf

	local make_eval
	use debug || make_eval="${make_eval} debug=no"
	make_eval="${make_eval} verbose=yes"

	emake ${make_eval} DESTDIR="${D}" install

	# Copy the documentation
	if use doc ; then
		dodir ${GNUSTEP_SYSTEM_DOC}
		cp -r Documentation/tmp-installation/System/Library/Documentation/* \
			"${ED}"${GNUSTEP_SYSTEM_DOC=}
	fi

	dodoc FAQ README RELEASENOTES

	exeinto /etc/profile.d
	doexe "${T}"/gnustep-4.sh
	doexe "${T}"/gnustep-4.csh
}

pkg_postinst() {
	# Warn about new layout if old GNUstep directory is still here
	if [ -e /usr/GNUstep/System ]; then
		ewarn "Old layout directory detected (/usr/GNUstep/System)"
		ewarn "Gentoo has switched to FHS layout for GNUstep packages"
		ewarn "You must first update the configuration files from this package,"
		ewarn "then remerge all packages still installed with the old layout"
		ewarn "You can use gnustep-base/gnustep-updater for this task"
	fi
}
