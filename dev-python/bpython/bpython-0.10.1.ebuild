# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_DEPEND="<<[ncurses]>>"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="*-jython"

inherit distutils

DESCRIPTION="Syntax highlighting and autocompletion for the Python interpreter"
HOMEPAGE="http://www.bpython-interpreter.org/ https://bitbucket.org/bobf/bpython/ http://pypi.python.org/pypi/bpython"
SRC_URI="http://www.bpython-interpreter.org/releases/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk nls urwid"

RDEPEND="$(python_abi_depend dev-python/pygments)
	$(python_abi_depend dev-python/setuptools)
	gtk? (
		$(python_abi_depend -e "2.5 *-pypy-* 3.*" dev-python/pygobject:2)
		$(python_abi_depend -e "2.5 *-pypy-* 3.*" dev-python/pygtk:2)
	)
	urwid? ( $(python_abi_depend dev-python/urwid) )"
DEPEND="${RDEPEND}
	nls? ( $(python_abi_depend -e "3.*" dev-python/Babel) )"

DOCS="sample-config sample.theme light.theme"
PYTHON_MODULES="bpdb bpython"

src_install() {
	distutils_src_install

	if use gtk; then
		# pygtk does not support Python 3.
		rm -f "${ED}"usr/bin/bpython-gtk-3.*
	else
		rm -f "${ED}"usr/bin/bpython-gtk*

		delete_unneeded_modules() {
			rm -f "${ED}$(python_get_sitedir)/bpython/gtk_.py"
		}
		python_execute_function -q delete_unneeded_modules
	fi

	if ! use urwid; then
		rm -f "${ED}"usr/bin/bpython-urwid*

		delete_urwid() {
			rm -f "${ED}$(python_get_sitedir)/bpython/urwid.py"
		}
		python_execute_function -q delete_urwid
	fi
}
