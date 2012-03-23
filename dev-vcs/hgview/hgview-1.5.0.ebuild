# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.* *-jython *-pypy-*"

inherit distutils

DESCRIPTION="Mercurial log navigator"
HOMEPAGE="http://www.logilab.org/project/hgview http://pypi.python.org/pypi/hgview"
SRC_URI="http://ftp.logilab.org/pub/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc +qt4 urwid"
REQUIRED_USE="|| ( qt4 urwid )"

RDEPEND="$(python_abi_depend dev-vcs/mercurial)
	qt4? ( 
		$(python_abi_depend dev-python/docutils)
		$(python_abi_depend dev-python/PyQt4[X])
		$(python_abi_depend dev-python/qscintilla-python)
	)
	urwid? (
		$(python_abi_depend dev-python/pygments)
		$(python_abi_depend dev-python/pyinotify)
		$(python_abi_depend dev-python/urwid)
	)"
DEPEND="${RDEPEND}
	doc? ( app-text/asciidoc )"

PYTHON_MODULES="hgext/hgview.py hgviewlib"

src_prepare() {
	distutils_src_prepare

	if ! use doc; then
		sed -e '/make -C doc/d' -i setup.py || die "sed failed"
		sed -e '/share\/man\/man1/,+1 d' -i hgviewlib/__pkginfo__.py || die "sed failed"
	fi
}

src_install() {
	distutils_src_install

	# Install Mercurial extension configuration file.
	insinto /etc/mercurial/hgrc.d
	doins hgext/hgview.rc
}
