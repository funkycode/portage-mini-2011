# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kexi/kexi-2.3.3.ebuild,v 1.3 2011/05/09 23:12:16 hwoarang Exp $

EAPI=3

KMNAME="koffice"
inherit kde4-meta

DESCRIPTION="KOffice integrated environment for database management"
KEYWORDS="amd64 x86"
IUSE="freetds mysql postgres reports xbase"

DEPEND="
	sys-libs/readline
	app-arch/bzip2
	~app-office/kspread-${PV}:${SLOT}
	freetds? ( dev-db/freetds )
	mysql? ( virtual/mysql )
	postgres? ( >=dev-libs/libpqxx-3 )
	reports? ( ~app-office/koffice-libs-${PV}:${SLOT}[reports] )
	xbase? ( dev-db/xbase )
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}"-2.3.0-link.patch )

KMLOADLIBS="koffice-libs"
KMEXTRACTONLY="
	KoConfig.h.cmake
	libs/
	kspread/
"

src_configure() {
	 mycmakeargs=(
		-DWITH_WEBFORMS=Off
		$(cmake-utils_use_with freetds FreeTDS)
		$(cmake-utils_use_with mysql MySQL)
		$(cmake-utils_use_with postgres PostgreSQL)
		$(cmake-utils_use_with postgres Pqxx)
		$(cmake-utils_use_with xbase XBase)
		-DBUILD_kexi=ON
		$(cmake-utils_use_build reports koreport)
	)

	kde4-meta_src_configure
}

src_install() {
	kde4-meta_src_install

	# this is already installed by koffice-data
	rm -f "${D}/usr/include/config-opengl.h"
	rm -f "${D}/usr/include/KoConfig.h"
}
