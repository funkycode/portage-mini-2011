# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/leechcraft-aggregator/leechcraft-aggregator-0.4.99.ebuild,v 1.3 2012/04/07 17:35:12 maekke Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Full-featured RSS/Atom feed reader for LeechCraft"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug mysql +sqlite postgres"

DEPEND="~net-misc/leechcraft-core-${PV}[postgres?,sqlite?]"
RDEPEND="${DEPEND}
		virtual/leechcraft-downloader-http"

REQUIRED_USE="|| ( mysql sqlite postgres )"

pkg_setup(){
	if use mysql; then
		ewarn "Support for MySQL databases is experimental and is more likely"
		ewarn "to contain bugs or mishandle your data than other storage"
		ewarn "backends. If you do not plan testing the MySQL storage backend"
		ewarn "itself, consider using other backends."
		ewarn "Anyway, it is perfectly safe to enable the mysql use flag as"
		ewarn "long as at least one other storage is enabled since you will"
		ewarn "be able to choose another storage backend at run time."
	fi
}
