# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/avrdude/avrdude-5.5.ebuild,v 1.6 2012/04/03 03:12:04 vapier Exp $

DESCRIPTION="AVR Downloader/UploaDEr"
HOMEPAGE="http://savannah.nongnu.org/projects/avrdude"
SRC_URI="mirror://nongnu/${PN}/${P}.tar.gz
	!doc? (
		mirror://nongnu/${PN}/${PN}-doc-${PV}.tar.gz
		mirror://nongnu/${PN}/${PN}-doc-${PV}.pdf
	)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="arm amd64 ~ppc ~ppc64 x86"
IUSE="doc"

RDEPEND="<dev-libs/libusb-1"
DEPEND="${RDEPEND}
	doc? ( app-text/texi2html
		virtual/latex-base
		sys-apps/texinfo )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# let the build system re-generate these, bug #120194
	rm -f lexer.c config_gram.c config_gram.h
}

src_compile() {
	econf --disable-dependency-tracking --disable-doc || die "econf failed"

	# Re-adding -j1 here (see bug #202576) but that should be fixed someday
	emake -j1 || die "emake failed"

	# We build docs separately since the makefile doesn't do it in a really nice way
	if use doc ; then
		cd doc
		VARTEXFONTS="${T}/fonts" emake -j1 || die "emake doc failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS NEWS README ChangeLog*

	# We either install docs we just built or those pre-made by upstream
	insinto /usr/share/doc/${PF}
	if use doc ; then
		cd doc
		doins avrdude.{ps,pdf}
	else
		newins "${DISTDIR}/${PN}-doc-${PV}.pdf" avrdude.pdf
		cd "${WORKDIR}"
	fi
	mv avrdude-html html
	doins -r html
}
