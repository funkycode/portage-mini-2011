# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libp11/libp11-0.2.8.ebuild,v 1.9 2012/03/06 21:45:37 ranger Exp $

EAPI="4"
inherit libtool

DESCRIPTION="A library implementing a layer on top of PKCS#11 API to make using PKCS#11 implementations easier."
HOMEPAGE="http://www.opensc-project.org/libp11/"

if [[ "${PV}" = "9999" ]]; then
	inherit autotools subversion
	ESVN_REPO_URI="http://www.opensc-project.org/svn/${PN}/trunk"
else
	SRC_URI="http://www.opensc-project.org/files/${PN}/${P}.tar.gz"
fi

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE="doc"

# libtool is required at runtime as it uses libltdl.
RDEPEND="dev-libs/openssl
	sys-devel/libtool"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

if [[ "${PV}" = "9999" ]]; then
	DEPEND="${DEPEND}
		app-text/docbook-xsl-stylesheets
		dev-libs/libxslt"
fi

src_prepare() {
	[[ "${PV}" = "9999" ]] && eautoreconf

	elibtoolize
}

src_configure() {
	econf \
		--docdir="/usr/share/doc/${PF}" \
		--htmldir="/usr/share/doc/${PF}/html" \
		--enable-shared --disable-static \
		--enable-doc \
		$(use_enable doc api-doc)
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	find "${D}" -name '*.la' -delete
}
