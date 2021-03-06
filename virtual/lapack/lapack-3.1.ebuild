# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/lapack/lapack-3.1.ebuild,v 1.5 2010/01/11 11:04:19 ulm Exp $

DESCRIPTION="Virtual for Linear Algebra Package FORTRAN 77 (LAPACK) implementation"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 s390 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND="|| (
		>=sci-libs/lapack-reference-3.1
		>=sci-libs/lapack-atlas-3.8.0
		>=sci-libs/mkl-10
		>=sci-libs/acml-4
	)"
DEPEND=""
