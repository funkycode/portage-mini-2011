# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/zeitgeist-extensions/zeitgeist-extensions-0.0.13.ebuild,v 1.1 2012/02/16 07:46:28 jlec Exp $

EAPI=4

PYTHON_DEPEND="2"
PYTHON_USE_WITH="sqlite"

inherit python

DESCRIPTION="Extensions to the engine such as Teamgeist, Relevancy Providers and Machine Learning Algorithms"
HOMEPAGE="https://launchpad.net/zeitgeist-extensions/"
SRC_URI="http://launchpad.net/${PN}/trunk/fts-${PV}/+download/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="GPL-3"
IUSE="fts geolocation memprofile sqldebug tracker"

RDEPEND="
	fts? (
		dev-libs/xapian-bindings[python]
		dev-python/dbus-python
		dev-python/pygobject
		dev-python/pyxdg
	)
	geolocation? (
		dev-python/dbus-python
		dev-python/python-geoclue
	)
	memprofile? (
		dev-python/dbus-python
	)
	sqldebug? ( dev-python/python-sqlparse )
	tracker? (
		app-misc/tracker
		dev-python/pygobject
		dev-python/dbus-python
	)"
DEPEND=""

src_install() {
	insinto /usr/share/zeitgeist/_zeitgeist/engine/extensions
	use fts && doins ./fts/fts.py
	if use geolocation; then
		dodoc ./geolocation/example.py
		doins ./geolocation/geolocation.py
	fi
	if use memprofile; then
		doins ./memory-profile/profile_memory.py
		newdoc ./memory-profile/README README-memprofile
	fi
	use sqldebug && doins ./debug_sql/debug_sql.py
	use tracker && doins ./tracker/tracker.py
}

pkg_postinst() {
	python_mod_optimize /usr/share/zeitgeist/_zeitgeist/engine/extensions
}

pkg_postrm() {
	python_mod_cleanup /usr/share/zeitgeist/_zeitgeist/engine/extensions
}
