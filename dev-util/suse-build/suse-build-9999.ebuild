# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/suse-build/suse-build-9999.ebuild,v 1.3 2012/03/07 13:36:56 miska Exp $

EAPI=4

EGIT_REPO_URI="git://gitorious.org/opensuse/build.git"
OPENSUSE_RELEASE="12.1"
MY_PN="build"
OBS_PACKAGE="${MY_PN}"

if [[ "${PV}" == "9999" ]]; then
	EXTRA_ECLASS="git-2"
else
	EXTRA_ECLASS="obs-download"
fi

inherit eutils ${EXTRA_ECLASS}
unset EXTRA_ECLASS

DESCRIPTION="Script to build SUSE Linux RPMs"
HOMEPAGE="https://build.opensuse.org/package/show?package=build&project=openSUSE%3ATools"

[[ "${PV}" == "9999" ]] || SRC_URI="${OBS_URI}/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
[[ "${PV}" == "9999" ]] || KEYWORDS="~amd64 ~x86"

RDEPEND="virtual/perl-Digest-MD5
	virtual/perl-Getopt-Long
	dev-perl/XML-Parser
	dev-perl/TimeDate
	app-shells/bash
	app-arch/rpm"

S="${WORKDIR}/${MY_PN}-${PV}"

src_compile() { :; }

src_install() {
	emake DESTDIR="${D}" pkglibdir=/usr/share/suse-build install
	cd "${ED}"/usr
	find bin -type l | while read i; do
		mv "${i}" "${i/bin\//bin/suse-}"
	done
	find share/man/man1 -type f | while read i; do
		mv "${i}" "${i/man1\//man1/suse-}"
	done
	find . -type f sed -i 's|/usr/lib/build|/usr/share/suse-build|' {} +
}
