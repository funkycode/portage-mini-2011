# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kuickshow/kuickshow-0.9.1.ebuild,v 1.4 2011/03/06 13:33:09 fauli Exp $

EAPI=3

KDE_LINGUAS="af ar be bg bn br ca ca@valencia cs cy da de el en_GB eo es et eu
fa fi fr ga gl he hi hne hr hu is it ja km lt lv mai mk ms nb nds ne nl nn oc pa
pl pt pt_BR ro ru se sk sl sv ta tg th tr uk uz uz@cyrillic vi xh zh_CN zh_TW"
KDE_DOC_DIRS="doc doc-translations/%lingua_${PN}"
inherit kde4-base

KDE_VERSION=4.4.0
MY_P=${P}-kde${KDE_VERSION}

DESCRIPTION="KDE4 program to view images"
HOMEPAGE="http://userbase.kde.org/KuickShow"
SRC_URI="mirror://kde/stable/${KDE_VERSION}/src/extragear/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE="debug +handbook"

DEPEND="media-libs/imlib
	!${CATEGORY}/${PN}:0"

DOCS="AUTHORS BUGS ChangeLog README TODO"

S=${WORKDIR}/${MY_P}
