# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/mdadm/mdadm-3.2.3-r1.ebuild,v 1.1 2012/02/16 03:10:04 vapier Exp $

EAPI="2"
inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="A useful tool for running RAID systems - it can be used as a replacement for the raidtools"
HOMEPAGE="http://neil.brown.name/blog/mdadm"
SRC_URI="mirror://kernel/linux/utils/raid/mdadm/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="static"

DEPEND=""
RDEPEND="!<sys-apps/baselayout-2
	>=sys-apps/util-linux-2.16"

# The tests edit values in /proc and run tests on software raid devices.
# Thus, they shouldn't be run on systems with active software RAID devices.
RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-3.2.1-mdassemble.patch #211426
	epatch "${FILESDIR}"/${PN}-3.2.3-segv-assemble.patch #211426
}

mdadm_emake() {
	emake \
		CC="$(tc-getCC)" \
		CWFLAGS="-Wall" \
		CXFLAGS="${CFLAGS}" \
		"$@" \
		|| die
}

src_compile() {
	use static && append-ldflags -static
	mdadm_emake all mdassemble
}

src_test() {
	mdadm_emake test

	sh ./test || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	into /
	dosbin mdassemble || die
	dodoc ChangeLog INSTALL TODO README* ANNOUNCE-${PV}

	insinto /etc
	newins mdadm.conf-example mdadm.conf
	newinitd "${FILESDIR}"/mdadm.rc mdadm || die
	newconfd "${FILESDIR}"/mdadm.confd mdadm || die
	newinitd "${FILESDIR}"/mdraid.rc mdraid || die
	newconfd "${FILESDIR}"/mdraid.confd mdraid || die

	# do not rely on /lib -> /libXX link
	sed -i \
		-e "s:/lib/rcscripts/:/$(get_libdir)/rcscripts/:" \
		"${D}"/etc/init.d/*
}

pkg_postinst() {
	elog "If you're not relying on kernel auto-detect of your RAID devices,"
	elog "you need to add 'mdraid' to your 'boot' runlevel:"
	elog "rc-update add mdraid boot"
}
