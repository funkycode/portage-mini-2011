# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/colord/colord-0.1.17.ebuild,v 1.1 2012/03/14 03:03:41 tetromino Exp $

EAPI="4"

inherit autotools eutils systemd base

DESCRIPTION="System service to accurately color manage input and output devices"
HOMEPAGE="http://www.freedesktop.org/software/colord/"
SRC_URI="http://www.freedesktop.org/software/colord/releases/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="doc examples +gusb +introspection scanner +udev vala"

COMMON_DEPEND="
	dev-db/sqlite:3
	>=dev-libs/glib-2.28.0:2
	>=media-libs/lcms-2.2:2
	>=sys-auth/polkit-0.103
	gusb? ( >=dev-libs/libgusb-0.1.1 )
	introspection? ( >=dev-libs/gobject-introspection-0.9.8 )
	scanner? ( media-gfx/sane-backends )
	udev? ( || ( sys-fs/udev[gudev] sys-fs/udev[extras] ) )
"
RDEPEND="${COMMON_DEPEND}
	media-gfx/shared-color-profiles"
DEPEND="${COMMON_DEPEND}
	dev-libs/libxslt
	>=dev-util/intltool-0.35
	dev-util/pkgconfig
	>=sys-devel/gettext-0.17
	doc? (
		app-text/docbook-xml-dtd:4.1.2
		>=dev-util/gtk-doc-1.9
	)
	vala? ( dev-lang/vala:0.14[vapigen] )
"

# FIXME: needs pre-installed dbus service files
RESTRICT="test"

DOCS=(AUTHORS ChangeLog MAINTAINERS NEWS README TODO)

pkg_setup() {
	enewgroup colord
	enewuser colord -1 -1 /var/lib/colord colord
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.1.11-fix-automagic-vala.patch"
	epatch "${FILESDIR}/${PN}-0.1.15-fix-automagic-libgusb.patch"

	# Upstream patch to fix glib-2.30 compat
	epatch "${FILESDIR}/${P}-glib-2.30.patch"

	eautoreconf
}

src_configure() {
	# Reverse tools require gusb
	econf \
		--disable-examples \
		--disable-static \
		--enable-polkit \
		--disable-volume-search \
		--with-daemon-user=colord \
		--localstatedir="${EPREFIX}"/var \
		$(use_enable doc gtk-doc) \
		$(use_enable gusb) \
		$(use_enable gusb reverse) \
		$(use_enable introspection) \
		$(use_enable scanner sane) \
		$(use_enable udev gudev) \
		$(use_enable vala) \
		$(systemd_with_unitdir) \
		VAPIGEN=$(type -p vapigen-0.14)
	# parallel make fails in doc/api
	use doc && MAKEOPTS="${MAKEOPTS} -j1"
}

src_install() {
	base_src_install

	# Ensure config and profile directories exist and are writable
	local d
	for d in /var/lib/{color,colord}; do
		keepdir "${d}"
		fowners colord:colord "${d}"
	done

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.c
	fi

	find "${D}" -name "*.la" -delete || die
}

pkg_postinst() {
	# <=colord-0.1.11 ran as root and used /var/lib/lib/colord to store
	# configuration files and /var/lib/lib/color for custom color profiles.
	local old_dir="${EROOT}var/lib/lib/colord"
	local new_dir="${EROOT}var/lib/colord"

	if [[ -e "${old_dir}/mapping.db" || -e "${old_dir}/storage.db" ]] && \
	   ! [[ -e "${new_dir}/mapping.db" || -e "${new_dir}/storage.db" ]]; then
		elog "Old colord configuration files are present in ${old_dir}. If you"
		elog "are upgrading from colord-0.1.11 or older and had previously"
		elog "customized your color management settings, you will need to copy"
		elog "these files to ${new_dir} and then change the file ownership"
		elog "to colord:colord :"
		elog
		elog " # cp ${old_dir}/*.db ${new_dir}"
		elog " # chown colord:colord ${new_dir}/*.db"
		elog
	fi
	old_dir="${EROOT}var/lib/lib/color"
	new_dir="${EROOT}var/lib/color"
	if [[ -e "${old_dir}/icc" && ! -e "${new_dir}/icc" ]]; then
		elog "Old custom color profiles are present in ${old_dir}. If you are"
		elog "upgrading from colord-0.1.11 or older, you will need to copy them"
		elog "to ${new_dir} and then change the ownership to colord:colord :"
		elog
		elog " # cp -r ${old_dir}/icc ${new_dir}"
		elog " # chown -R colord:colord ${new_dir}/icc"
		elog
	fi
}
