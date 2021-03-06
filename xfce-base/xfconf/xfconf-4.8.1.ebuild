# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfconf/xfconf-4.8.1.ebuild,v 1.6 2012/03/23 21:29:28 angelos Exp $

EAPI=4
inherit xfconf

DESCRIPTION="A simple client-server configuration storage and query system for the Xfce desktop environment"
HOMEPAGE="http://www.xfce.org/projects/xfconf"
SRC_URI="mirror://xfce/src/xfce/xfconf/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ppc ppc64 ~sh ~sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~x64-solaris"
IUSE="debug perl"

RDEPEND=">=dev-libs/dbus-glib-0.90
	>=dev-libs/glib-2.18:2
	>=xfce-base/libxfce4util-4.8
	perl? ( dev-perl/glib-perl )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext
	perl? (
		dev-perl/extutils-depends
		dev-perl/extutils-pkgconfig
		)"

RESTRICT="test"

pkg_setup() {
	XFCONF=(
		--disable-static
		$(use_enable perl perl-bindings)
		$(xfconf_use_debug)
		$(use_enable debug checks)
		--with-perl-options=INSTALLDIRS=vendor
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html
		)

	[[ ${CHOST} == *-darwin* ]] && XFCONF+=( --disable-visibility ) #366857

	DOCS=( AUTHORS ChangeLog NEWS TODO )
}

src_compile() {
	emake OTHERLDFLAGS="${LDFLAGS}"
}

src_install() {
	xfconf_src_install

	if use perl; then
		find "${ED}" -type f -name perllocal.pod -delete
		find "${ED}" -depth -mindepth 1 -type d -empty -delete
	fi
}
