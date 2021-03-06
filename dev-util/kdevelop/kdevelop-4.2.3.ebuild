# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevelop/kdevelop-4.2.3.ebuild,v 1.5 2012/03/11 14:43:01 ago Exp $

EAPI=4

KDE_LINGUAS="ca ca@valencia da de en_GB es et fr it nb nds nl pt pt_BR ru sl sv th uk zh_CN zh_TW"
VIRTUALX_REQUIRED=test
inherit kde4-base

DESCRIPTION="Integrated Development Environment for Unix, supporting KDE/Qt, C/C++ and many other languages."

KEYWORDS="amd64 ~ppc ~ppc64 ~x86"
LICENSE="GPL-2 LGPL-2"
IUSE="+cmake +cxx debug okteta qthelp"

# Remove ksysguard dep after libprocessui moved into kdelibs
DEPEND="
	dev-util/kdevplatform[subversion]
	$(add_kdebase_dep ksysguard)
	$(add_kdebase_dep libkworkspace)
	okteta? ( $(add_kdebase_dep okteta) )
	qthelp? ( >=x11-libs/qt-assistant-4.4:4 )
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kapptemplate)
	cxx? ( >=sys-devel/gdb-7.0[python] )
"
# see bug 347547 about the kdevplatform[subversion] dependency

RESTRICT="test"
# see bug 366471

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build cmake)
		$(cmake-utils_use_build cmake cmakebuilder)
		$(cmake-utils_use_build cxx cpp)
		$(cmake-utils_use_with okteta LibKasten)
		$(cmake-utils_use_with okteta LibOkteta)
		$(cmake-utils_use_with okteta LibOktetaKasten)
		$(cmake-utils_use_build qthelp)
	)

	kde4-base_src_configure
}
