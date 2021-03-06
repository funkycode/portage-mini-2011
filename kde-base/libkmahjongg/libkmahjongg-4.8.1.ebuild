# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkmahjongg/libkmahjongg-4.8.1.ebuild,v 1.2 2012/04/04 19:08:26 ago Exp $

EAPI=4

KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="LibKMahjongg for KDE"
KEYWORDS="amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

KMLOADLIBS="libkdegames"
