# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/filelight/filelight-4.8.2.ebuild,v 1.1 2012/04/04 23:59:06 johu Exp $

EAPI=4

KDE_HANDBOOK="optional"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="Filelight creates an interactive map of concentric, segmented rings that help visualise disk usage."

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	x11-apps/xdpyinfo
"
