# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/libreoffice-bin-debug/libreoffice-bin-debug-3.4.5.2-r1.ebuild,v 1.3 2012/03/02 15:17:14 ago Exp $

EAPI=4

BASE_AMD64_URI="mirror://gentoo/amd64-debug-"
BASE_X86_URI="mirror://gentoo/x86-debug-"

DESCRIPTION="LibreOffice, a full office productivity suite. Binary package, debug info."
HOMEPAGE="http://www.libreoffice.org"
SRC_URI_AMD64="
	kde? (
		!java? ( ${BASE_AMD64_URI}${PN/-bin-debug}-kde-${PVR}.tbz2 )
		java? ( ${BASE_AMD64_URI}${PN/-bin-debug}-kde-java-${PVR}.tbz2 )
	)
	gnome? (
		!java? ( ${BASE_AMD64_URI}${PN/-bin-debug}-gnome-${PVR}.tbz2 )
		java? ( ${BASE_AMD64_URI}${PN/-bin-debug}-gnome-java-${PVR}.tbz2 )
	)
	!kde? ( !gnome? (
		!java? ( ${BASE_AMD64_URI}${PN/-bin-debug}-base-${PVR}.tbz2 )
		java? ( ${BASE_AMD64_URI}${PN/-bin-debug}-base-java-${PVR}.tbz2 )
	) )
"
SRC_URI_X86="
	kde? (
		!java? ( ${BASE_X86_URI}${PN/-bin-debug}-kde-${PVR}.tbz2 )
		java? ( ${BASE_X86_URI}${PN/-bin-debug}-kde-java-${PVR}.tbz2 )
	)
	gnome? (
		!java? ( ${BASE_X86_URI}${PN/-bin-debug}-gnome-${PVR}.tbz2 )
		java? ( ${BASE_X86_URI}${PN/-bin-debug}-gnome-java-${PVR}.tbz2 )
	)
	!kde? ( !gnome? (
		!java? ( ${BASE_X86_URI}${PN/-bin-debug}-base-${PVR}.tbz2 )
		java? ( ${BASE_X86_URI}${PN/-bin-debug}-base-java-${PVR}.tbz2 )
	) )
"

SRC_URI="
	amd64? ( ${SRC_URI_AMD64} )
	x86? ( ${SRC_URI_X86} )
"

IUSE="gnome java kde"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="-* amd64 ~x86"

RDEPEND="=app-office/${PN}-${PVR}[gnome=,java=,kde=]"

RESTRICT="test strip"

S="${WORKDIR}"

src_configure() { :; }

src_compile() { :; }

src_install() {
	dodir /usr
	cp -aR "${S}"/usr/* "${ED}"/usr/
}
