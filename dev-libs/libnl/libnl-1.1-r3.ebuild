# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libnl/libnl-1.1-r3.ebuild,v 1.1 2012/04/03 15:11:10 jer Exp $

EAPI=4

inherit eutils multilib

DESCRIPTION="A library for applications dealing with netlink socket"
HOMEPAGE="http://www.infradead.org/~tgr/libnl/"
SRC_URI="http://www.infradead.org/~tgr/libnl/files/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="1.1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="doc"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

PATCHES=( ChangeLog )

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-vlan-header.patch \
		"${FILESDIR}"/${P}-minor-leaks.patch \
		"${FILESDIR}"/${P}-glibc-2.8-ULONG_MAX.patch \
		"${FILESDIR}"/${P}-flags.patch \
		"${FILESDIR}"/${P}-inline.patch
}

src_compile() {
	default

	if use doc ; then
		cd "${S}/doc"
		emake gendoc || die "emake gendoc failed"
	fi
}

src_install() {
	default

	if use doc ; then
		cd "${S}/doc"
		dohtml -r html/*
	fi
}
