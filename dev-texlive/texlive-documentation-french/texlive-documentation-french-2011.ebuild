# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-french/texlive-documentation-french-2011.ebuild,v 1.8 2012/03/04 15:42:53 klausman Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="apprends-latex epslatex-fr impatient-fr l2tabu-french lshort-french texlive-fr collection-documentation-french
"
TEXLIVE_MODULE_DOC_CONTENTS="apprends-latex.doc epslatex-fr.doc impatient-fr.doc l2tabu-french.doc lshort-french.doc texlive-fr.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit  texlive-module
DESCRIPTION="TeXLive French documentation"

LICENSE="GPL-2 FDL-1.1 GPL-1 LPPL-1.3 "
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2011
"
RDEPEND="${DEPEND} "
