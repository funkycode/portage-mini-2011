# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-tabpp/leechcraft-tabpp-0.4.99.ebuild,v 1.3 2012/04/07 17:33:56 maekke Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Tab++ provides enhanced tab-related features like tab tree for LeechCraft"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"
