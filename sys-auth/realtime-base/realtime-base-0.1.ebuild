# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/realtime-base/realtime-base-0.1.ebuild,v 1.14 2012/03/13 14:42:28 ssuominen Exp $

EAPI=3

inherit eutils

DESCRIPTION="Sets up realtime scheduling"
HOMEPAGE="http://www.jackaudio.org/linux_rt_config"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ~ia64 ppc ppc64 ~sh ~sparc x86"
IUSE=""

DEPEND=""
RDEPEND="virtual/pam"

limitsdfile=40-${PN}.conf
rtgroup=realtime

S=${WORKDIR}

pkg_setup() {
	enewgroup ${rtgroup}
}

print_limitsdfile() {
	printf "# Start of ${limitsdfile} from ${P}\n\n"
	printf "@${rtgroup}\t-\trtprio\t99\n"
	printf "@${rtgroup}\t-\tmemlock\tunlimited\n"
	printf "\n# End of ${limitsdfile} from ${P}\n"
}

src_compile() {
	einfo "Generating ${limitsdfile}"
	print_limitsdfile > "${S}/${limitsdfile}"
}

src_install() {
	insinto /etc/security/limits.d/
	doins "${S}/${limitsdfile}" || die
}

pkg_postinst() {
	elog "We have added realtime scheduling privileges for users in the ${rtgroup} group."
	elog "Please make sure users needing such privileges are in that group."
}
