# Copyright owners: Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: waf-utils.eclass
# @MAINTAINER:
# gnome@gentoo.org
# @AUTHOR:
# Original Author: Gilles Dartiguelongue <eva@gentoo.org>
# Various improvements based on cmake-utils.eclass: Tomáš Chvátal <scarabeus@gentoo.org>
# Proper prefix support: Jonathan Callen <abcd@gentoo.org>
# @BLURB: common ebuild functions for waf-based packages
# @DESCRIPTION:
# The waf-utils eclass contains functions that make creating ebuild for
# waf-based packages much easier.
# Its main features are support of common portage default settings.

inherit base eutils multilib toolchain-funcs

case ${EAPI:-0} in
	4-python|4|3) EXPORT_FUNCTIONS src_configure src_compile src_install ;;
	*) die "EAPI=${EAPI} is not supported" ;;
esac

# @FUNCTION: waf-utils_src_configure
# @DESCRIPTION:
# General function for configuring with waf.
waf-utils_src_configure() {
	debug-print-function ${FUNCNAME} "$@"

	# @ECLASS-VARIABLE: WAF_BINARY
	# @DESCRIPTION:
	# Eclass can use different waf executable. Usually it is located in "${S}/waf".
	: ${WAF_BINARY:="${S}/waf"}

	tc-export AR CC CPP CXX RANLIB
	echo "CCFLAGS=\"${CFLAGS}\" LINKFLAGS=\"${LDFLAGS}\" \"${WAF_BINARY}\" --prefix=${EPREFIX}/usr --libdir=${EPREFIX}/usr/$(get_libdir) $@ configure"

	CCFLAGS="${CFLAGS}" LINKFLAGS="${LDFLAGS}" "${WAF_BINARY}" \
		"--prefix=${EPREFIX}/usr" \
		"--libdir=${EPREFIX}/usr/$(get_libdir)" \
		"$@" \
		configure || die "configure failed"
}

# @FUNCTION: waf-utils_src_compile
# @DESCRIPTION:
# General function for compiling with waf.
waf-utils_src_compile() {
	debug-print-function ${FUNCNAME} "$@"

	local jobs=$(echo -j1 ${MAKEOPTS} | sed -r "s/.*(-j\s*|--jobs=)([0-9]+).*/--jobs=\2/" )
	echo "\"${WAF_BINARY}\" build ${jobs}"
	"${WAF_BINARY}" ${jobs} || die "build failed"
}

# @FUNCTION: waf-utils_src_install
# @DESCRIPTION:
# Function for installing the package.
waf-utils_src_install() {
	debug-print-function ${FUNCNAME} "$@"

	echo "\"${WAF_BINARY}\" --destdir=\"${D}\" install"
	"${WAF_BINARY}" --destdir="${D}" install  || die "Make install failed"

	# Manual document installation
	base_src_install_docs
}
