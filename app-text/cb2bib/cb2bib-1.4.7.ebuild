# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/cb2bib/cb2bib-1.4.7.ebuild,v 1.3 2012/04/10 08:15:06 ago Exp $

EAPI=4

inherit cmake-utils qt4-r2

DESCRIPTION="Tool for extracting unformatted bibliographic references"
HOMEPAGE="http://www.molspaces.com/cb2bib/"
SRC_URI="http://www.molspaces.com/dl/progs/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="amd64 x86"
IUSE="debug +lzo +poll"

DEPEND="
	x11-libs/libX11
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-webkit:4
	lzo? ( dev-libs/lzo )
"
RDEPEND="${DEPEND}"

src_configure() {
	if use !lzo; then
		mycmakeargs+=( -DC2B_USE_LZO=OFF )
	fi

	if use !poll; then
		mycmakeargs+=( -DC2B_USE_POLL=OFF )
	fi

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install

	rm "${D}"/usr/share/${PN}/COPYRIGHT || die "rm COPYRIGHT failed"
	rm "${D}"/usr/share/${PN}/LICENSE || die "rm LICENSE failed"
}

pkg_postinst() {
	elog "For best functionality, emerge the following packages:"
	elog "    app-text/poppler-utils  - for data import from PDF files"
	elog "    app-text/dvipdfm        - for data import from DVI files"
	elog "    app-text/bibutils       - for data import from ISI, endnote format"
	elog "    media-fonts/jsmath      - for displaying mathematical notation"
	elog "    media-libs/exiftool     - for proper UTF-8 metadata writing in PDF"
	elog "                              text strings"
	elog "    virtual/latex-base      - to check for BibTeX file correctness and to get"
	elog "                              nice printing through the shell script bib2pdf"
}
