# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/propel-runtime/propel-runtime-1.6.4.ebuild,v 1.1 2012/01/31 09:11:32 olemarkus Exp $

EAPI="4"
inherit php-pear-lib-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Object Persistence Layer for PHP 5 (Runtime)."
HOMEPAGE="http://propelorm.org"
SRC_URI="http://pear.propelorm.org/get/propel_runtime-${PV}.tgz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/php-5.3[pdo,xml,xsl]
	>=dev-php/pear-1.9.0-r1"
RDEPEND="${DEPEND}
	>=dev-php/PEAR-Log-1.8.7-r1
	"

S="${WORKDIR}/propel_runtime-${PV}"

need_php_by_category
