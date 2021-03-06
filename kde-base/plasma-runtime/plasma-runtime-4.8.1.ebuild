# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/plasma-runtime/plasma-runtime-4.8.1.ebuild,v 1.4 2012/04/04 19:19:17 ago Exp $

EAPI=4

KMNAME="kde-runtime"
KMMODULE="plasma"
DECLARATIVE_REQUIRED="always"
inherit kde4-meta

DESCRIPTION="Script engine and package tool for plasma"
KEYWORDS="amd64 ~arm ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

# file collisions, bug 394997
add_blocker plasma-workspace 4.4.50
