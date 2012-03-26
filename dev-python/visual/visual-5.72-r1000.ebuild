# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="*-jython *-pypy-*"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"

inherit flag-o-matic multilib python versionator

MY_P="${PN}-$(delete_version_separator 2)_release"

DESCRIPTION="Real-time 3D graphics library for Python"
HOMEPAGE="http://www.vpython.org/"
SRC_URI="http://www.vpython.org/contents/download/${MY_P}.tar.bz2"

LICENSE="visual"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc examples"

RDEPEND=">=dev-cpp/gtkglextmm-1.2
	dev-cpp/libglademm
	$(python_abi_depend ">=dev-libs/boost-1.48[python]")
	$(python_abi_depend dev-python/numpy)
	$(python_abi_depend -i "2.*" dev-python/polygon:2)
	$(python_abi_depend -i "3.*" dev-python/polygon:3)
	$(python_abi_depend -i "2.*" dev-python/ttfquery)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# Delete redundant file, which causes compilation failure.
	rm -f src/gtk2/random_device.cpp
	sed -e "s/ random_device.l\?o//" -i src/Makefile.in src/gtk2/makefile || die "sed failed"

	# Verbose build.
	sed -e 's/2\?>>[[:space:]]*\$(LOGFILE).*//' -i src/Makefile.in || die "sed failed"

	# Avoid version suffix in cvisualmodule.so.
	sed -e "s/-module/-avoid-version -module/" -i src/Makefile.in || die "sed failed"

	# Fix compatibility with Python 3.
	sed -e '/initcvisual;/a\\t\tPyInit_cvisual;' -i src/linux-symbols.map || die "sed failed"

	python_clean_py-compile_files
	python_src_prepare

	preparation() {
		sed \
			-e "s/-lboost_python/-lboost_python-${PYTHON_ABI}/" \
			-e "s/libboost_python/libboost_python-${PYTHON_ABI}/" \
			-i src/Makefile.in src/gtk2/makefile
	}
	python_execute_function -s preparation
}

src_configure() {
	BOOST_PKG="$(best_version ">=dev-libs/boost-1.48")"
	BOOST_VER="$(get_version_component_range 1-2 "${BOOST_PKG/*boost-/}")"
	BOOST_VER="$(replace_all_version_separators _ "${BOOST_VER}")"
	BOOST_INC="${EPREFIX}/usr/include/boost-${BOOST_VER}"
	BOOST_LIB="${EPREFIX}/usr/$(get_libdir)/boost-${BOOST_VER}"

	# Specify the include and lib directory for Boost.
	append-cxxflags -I${BOOST_INC}
	append-ldflags -L${BOOST_LIB}

	python_src_configure \
		--with-example-dir="${EPREFIX}/usr/share/doc/${PF}/examples" \
		--with-html-dir="${EPREFIX}/usr/share/doc/${PF}/html" \
		$(use_enable doc docs) \
		$(use_enable examples)
}

src_install() {
	python_src_install
	python_clean_installation_image

	dodoc authors.txt HACKING.txt NEWS.txt

	# Don't install useless vpython script.
	rm -fr "${ED}usr/bin"
}

pkg_postinst() {
	python_mod_optimize vis visual
}

pkg_postrm() {
	python_mod_cleanup vis visual
}
