# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_DEPEND="<<[tk?]>>"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5 3.* *-jython *-pypy-*"
WX_GTK_VER="2.8"

inherit distutils

DESCRIPTION="Python plotting package"
HOMEPAGE="http://matplotlib.sourceforge.net/ http://pypi.python.org/pypi/matplotlib"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	doc? ( mirror://sourceforge/${PN}/mpl_sampledata-${PV}.tar.gz )
	examples? ( mirror://sourceforge/${PN}/mpl_sampledata-${PV}.tar.gz )"

# Main license: matplotlib
# Some modules: BSD
# matplotlib/backends/qt4_editor: MIT
# Fonts: BitstreamVera, OFL-1.1
LICENSE="BitstreamVera BSD matplotlib MIT OFL-1.1"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="cairo doc examples excel fltk gtk latex qt4 tk wxwidgets"

CDEPEND="$(python_abi_depend dev-python/numpy)
	$(python_abi_depend dev-python/python-dateutil)
	$(python_abi_depend dev-python/pytz)
	media-libs/freetype:2
	media-libs/libpng
	gtk? ( $(python_abi_depend dev-python/pygtk) )
	wxwidgets? ( $(python_abi_depend dev-python/wxpython:2.8) )"

DEPEND="${CDEPEND}
	$(python_abi_depend dev-python/pycxx)
	dev-util/pkgconfig
	doc? (
		app-text/dvipng
		$(python_abi_depend dev-python/imaging)
		$(python_abi_depend dev-python/ipython)
		$(python_abi_depend dev-python/sphinx)
		$(python_abi_depend dev-python/xlwt)
		dev-texlive/texlive-fontsrecommended
		dev-texlive/texlive-latexextra
		dev-texlive/texlive-latexrecommended
		media-gfx/graphviz[cairo]
	)"

RDEPEND="${CDEPEND}
	$(python_abi_depend dev-python/pyparsing)
	media-fonts/stix-fonts
	media-fonts/texcm-ttf
	virtual/ttf-fonts
	cairo? ( $(python_abi_depend dev-python/pycairo) )
	excel? ( $(python_abi_depend dev-python/xlwt) )
	fltk? ( $(python_abi_depend dev-python/pyfltk) )
	latex? (
		app-text/dvipng
		app-text/ghostscript-gpl
		app-text/poppler[utils]
		dev-texlive/texlive-fontsrecommended
		virtual/latex-base
	)
	qt4? ( || (
		$(python_abi_depend dev-python/PyQt4[X])
		dev-python/pyside
	) )"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")
PYTHON_CXXFLAGS=("2.* + -fno-strict-aliasing")

PYTHON_MODULES="matplotlib mpl_toolkits pylab.py"

use_setup() {
	local uword="${2:-${1}}"
	if use ${1}; then
		echo "${uword} = True"
		echo "${uword}agg = True"
	else
		echo "${uword} = False"
		echo "${uword}agg = False"
	fi
}

src_prepare() {
	# Create setup.cfg (see setup.cfg.template for any changes).
	cat > setup.cfg <<-EOF
		[provide_packages]
		pytz = False
		dateutil = False
		[gui_support]
		$(use_setup cairo)
		$(use_setup fltk)
		$(use_setup gtk)
		$(use_setup qt4)
		$(use_setup tk)
		$(use_setup wxwidgets wx)
	EOF

	# Avoid checks needing a X display.
	sed \
		-e "s/check_for_gtk()/$(use gtk && echo True || echo False)/" \
		-e "s/check_for_tk()/$(use tk && echo True || echo False)/" \
		-i setup.py || die "sed failed"

	# Respect FHS:
	# - mpl-data in /usr/share/matplotlib
	# - config files in /etc/matplotlib
	sed \
		-e "/'mpl-data\/matplotlibrc',/d" \
		-e "/'mpl-data\/matplotlib.conf',/d" \
		-e "s:'lib/matplotlib/mpl-data/matplotlibrc':'matplotlibrc':" \
		-e "s:'lib/matplotlib/mpl-data/matplotlib.conf':'matplotlib.conf':" \
		-i setup.py || die "sed failed"

	# Delete internal copies of pycxx and pyparsing.
	rm -fr CXX lib/matplotlib/pyparsing.py || die "Deletion of internal copies failed"

	# Use stix fonts.
	sed -e "/fontset/s/cm/stix/" -i lib/matplotlib/mpl-data/matplotlib.conf* || die "sed failed"

	sed -e "s/matplotlib.pyparsing/pyparsing/g" -i lib/matplotlib/{mathtext,fontconfig_pattern}.py || die "sed failed"

	if use doc || use examples; then
		cat <<- EOF >> doc/matplotlibrc
			examples.download : False
			examples.directory : ${WORKDIR}/mpl_sampledata-${PV}
			EOF
		cat <<- EOF >> matplotlibrc.template
			examples.download : False
			examples.directory : ${EPREFIX}/usr/share/doc/${PF}/examples
			EOF
	fi
}

src_compile() {
	unset DISPLAY

	distutils_src_compile_pre_hook() {
		ln -fs "${EPREFIX}/usr/share/python$(python_get_version)/CXX" .
	}
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		pushd doc > /dev/null
		export VARTEXFONTS="${T}/fonts"
		python_execute MATPLOTLIBDATA="${S}/lib/matplotlib/mpl-data" PYTHONPATH="$(ls -d ../build-$(PYTHON -f --ABI)/lib*)" VARTEXFONTS="${T}/fonts" "$(PYTHON -f)" make.py --small all || die "Generation of documentation failed"
		[[ -e build/latex/Matplotlib.pdf ]] || die "Generation of documentation failed"
		popd > /dev/null
	fi
}

src_test() {
	cd examples/tests

	testing() {
		python_execute PYTHONPATH="$(ls -d ../../build-${PYTHON_ABI}/lib*)" "$(PYTHON)" backend_driver.py agg || return
		python_execute PYTHONPATH="$(ls -d ../../build-${PYTHON_ABI}/lib*)" "$(PYTHON)" backend_driver.py --clean
	}
	python_execute_function testing
}

src_install() {
	# Apply changes only after generation of documentation, to allow using default configs.
	sed \
		-e "s:path =  get_data_path():path = '${EPREFIX}/etc/matplotlib':" \
		-e "s:os.path.dirname(__file__):'${EPREFIX}/usr/share/${PN}':g" \
		-i build-*/lib*/matplotlib/__init__.py || die "sed failed"

	distutils_src_install

	# Delete internal copies of some fonts.
	delete_fonts() {
		rm "${ED}$(python_get_sitedir)/matplotlib/mpl-data/fonts/ttf/"cm{ex,mi,r,sy}10.ttf || return
		rm "${ED}$(python_get_sitedir)/matplotlib/mpl-data/fonts/ttf/"{Vera*,*.TXT} || return
		rm -r "${ED}$(python_get_sitedir)/matplotlib/mpl-data/fonts/"{afm,pdfcorefonts}
	}
	python_execute_function -q delete_fonts

	# Respect FHS.
	dodir /usr/share/${PN}
	mv "${ED}$(python_get_sitedir -f)/${PN}/"{mpl-data,backends/Matplotlib.nib} "${ED}usr/share/${PN}" || die "Renaming failed"
	delete_mpl-data_and_Matplotlib.nib() {
		rm -fr "${ED}$(python_get_sitedir)/${PN}/"{mpl-data,backends/Matplotlib.nib}
	}
	python_execute_function -q delete_mpl-data_and_Matplotlib.nib

	insinto /etc/matplotlib
	doins matplotlibrc matplotlib.conf

	# Install documentation and examples.
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r doc/build/latex/Matplotlib.pdf doc/build/html
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r "${WORKDIR}/mpl_sampledata-${PV}/"*
	fi
}
