# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libbeagle/libbeagle-0.3.9.ebuild,v 1.3 2009/04/04 14:51:54 maekke Exp $

EAPI=2

inherit gnome.org

DESCRIPTION="C and Python bindings for Beagle"
HOMEPAGE="http://beagle-project.org/"

LICENSE="MIT Apache-1.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="debug doc +python"

RDEPEND=">=dev-libs/glib-2.6
	>=dev-libs/libxml2-2.6.19
	python? ( >=dev-lang/python-2.3
		>=dev-python/pygtk-2.6 )
	!<=app-misc/beagle-0.2.18"
DEPEND="${RDEPEND}
	doc? ( dev-util/gtk-doc )"

src_compile() {
	econf	--disable-dependency-tracking \
		$(use_enable python) \
		$(use_enable doc gtk-doc) \
		$(use_enable debug xml-dump)
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed!"
}
