# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/krosspython/krosspython-4.8.1.ebuild,v 1.2 2012/04/04 18:43:16 ago Exp $

EAPI=4

KDE_SCM="git"
KMNAME="kross-interpreters"
KMMODULE="python"
PYTHON_DEPEND="2"
inherit python kde4-meta

DESCRIPTION="Kross scripting framework: Python interpreter"
KEYWORDS="amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
	kde4-meta_pkg_setup
}
