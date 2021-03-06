# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/fieldslib/fieldslib-0.1.2.ebuild,v 1.2 2012/03/27 21:06:21 aballier Exp $

EAPI="3"
inherit oasis

DESCRIPTION="Folding over record fields"
HOMEPAGE="http://www.janestreet.com/ocaml"
SRC_URI="http://www.janestreet.com/ocaml/${P}.tar.gz"

LICENSE="LGPL-2.1-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-ml/type-conv-2.3.0"
RDEPEND="${DEPEND}"

DOCS=( "README" )
