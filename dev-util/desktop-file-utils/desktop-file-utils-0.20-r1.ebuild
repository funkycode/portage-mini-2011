# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/desktop-file-utils/desktop-file-utils-0.20-r1.ebuild,v 1.1 2012/04/05 07:10:13 ssuominen Exp $

EAPI=4
inherit elisp-common eutils

DESCRIPTION="Command line utilities to work with desktop menu entries"
HOMEPAGE="http://freedesktop.org/wiki/Software/desktop-file-utils"
SRC_URI="http://www.freedesktop.org/software/${PN}/releases/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="emacs"

RDEPEND=">=dev-libs/glib-2.12
	emacs? ( virtual/emacs )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

SITEFILE=50${PN}-gentoo.el

DOCS=( AUTHORS ChangeLog HACKING NEWS README )

src_prepare() {
	epatch "${FILESDIR}"/${P}-validate_Categories_XFCE.patch

	sed -i -e '/SUBDIRS =/s:misc::' Makefile.in || die
}

src_configure() {
	econf "$(use_with emacs lispdir "${SITELISP}"/${PN})"
}

src_compile() {
	default
	use emacs && elisp-compile misc/desktop-entry-mode.el
}

src_install() {
	default
	if use emacs; then
		elisp-install ${PN} misc/*.el misc/*.elc || die
		elisp-site-file-install "${FILESDIR}"/${SITEFILE} || die
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
