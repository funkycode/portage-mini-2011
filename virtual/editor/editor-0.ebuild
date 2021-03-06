# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/editor/editor-0.ebuild,v 1.25 2011/12/22 20:29:38 ulm Exp $

EAPI=2

DESCRIPTION="Virtual for editor"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

# Add a package to RDEPEND only if the editor:
# - can edit ordinary text files,
# - works on the console.

DEPEND=""
RDEPEND="|| ( app-editors/nano
	app-editors/dav
	app-editors/e3
	app-editors/ee
	app-editors/efte
	app-editors/elvis
	app-editors/emacs
	app-editors/emacs-vcs
	app-editors/emact
	app-editors/ersatz-emacs
	app-editors/fe
	app-editors/jasspa-microemacs
	app-editors/jed
	app-editors/joe
	app-editors/jove
	app-editors/le
	app-editors/levee
	app-editors/lpe
	app-editors/mg
	app-editors/ne
	app-editors/ng
	app-editors/nvi
	app-editors/qemacs
	app-editors/teco
	app-editors/uemacs-pk
	app-editors/vile
	app-editors/vim
	app-editors/gvim
	app-editors/xemacs
	app-editors/zile
	app-misc/mc[edit]
	dev-lisp/cmucl
	mail-client/pine
	sys-apps/ed )"

# Packages outside app-editors providing an editor:
#	app-misc/mc: mcedit (#62643)
#	dev-lisp/cmucl: hemlock
#	mail-client/pine: pico
#	sys-apps/busybox: vi
