# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/zathura/zathura-0.1.2.ebuild,v 1.1 2012/03/30 05:48:17 ssuominen Exp $

EAPI=4
inherit eutils multilib toolchain-funcs

DESCRIPTION="A highly customizable and functional document viewer"
HOMEPAGE="http://pwmt.org/projects/zathura/"
SRC_URI="http://pwmt.org/projects/${PN}/download/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sqlite"

RDEPEND=">=dev-libs/girara-0.1.2:2
	sqlite? ( dev-db/sqlite:3 )"
DEPEND="${RDEPEND}
	dev-python/docutils
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	myzathuraconf=(
		ZATHURA_GTK_VERSION=2
		WITH_SQLITE=$(usex sqlite 1 0)
		LIBDIR='${PREFIX}'/$(get_libdir)
		RSTTOMAN="$(type -P rst2man.py)"
		CC="$(tc-getCC)"
		SFLAGS=""
		VERBOSE=1
		DESTDIR="${D}"
		)
}

src_compile() {
	emake "${myzathuraconf[@]}"
}

src_install() {
	emake "${myzathuraconf[@]}" install
	dodoc AUTHORS
}

pkg_postinst() {
	elog "You can install app-text/zathura-pdf-poppler for PDF support."
}
