# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gdl/gdl-0.9.2.ebuild,v 1.1 2011/12/27 08:01:38 bicatali Exp $

EAPI=4

WX_GTK_VER="2.8"
PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"

inherit cmake-utils eutils wxwidgets python virtualx

RESTRICT_PYTHON_ABIS="3.*"

DESCRIPTION="Interactive Data Language compatible incremental compiler"
HOMEPAGE="http://gnudatalanguage.sourceforge.net/"
SRC_URI="mirror://sourceforge/gnudatalanguage/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fftw grib gshhs hdf hdf5 imagemagick netcdf openmp proj ps python
	static-libs udunits wxwidgets X"

RDEPEND="sci-libs/gsl
	sci-libs/plplot
	sys-libs/ncurses
	sys-libs/readline
	sys-libs/zlib
	fftw? ( >=sci-libs/fftw-3 )
	grib? ( sci-libs/grib_api )
	gshhs? ( sci-geosciences/gshhs-data sci-geosciences/gshhs )
	hdf? ( sci-libs/hdf )
	hdf5? ( sci-libs/hdf5 )
	imagemagick? ( media-gfx/imagemagick )
	netcdf? ( sci-libs/netcdf )
	proj? ( sci-libs/proj )
	ps? ( dev-libs/pslib )
	python? ( dev-python/numpy )
	udunits? ( sci-libs/udunits )
	wxwidgets? ( x11-libs/wxGTK:2.8[X] )"

DEPEND="${RDEPEND}
	>=dev-java/antlr-2.7.7-r5:0[cxx]"

pkg_setup() {
	use wxwidgets && wxwidgets_pkg_setup
	use python && python_pkg_setup
}

src_prepare() {
	use hdf5 && has_version sci-libs/hdf5[mpi] && export CXX=mpicxx
	epatch "${FILESDIR}"/${PV}-{antlr,numpy,proj4,include,tests}.patch
	# make sure antlr includes are from system
	rm -rf src/antlr
	# gentoo: use proj instead of libproj4 (libproj4 last update: 2004)
	sed -i \
		-e 's:proj4:proj:' \
		-e 's:lib_proj\.h:proj_api\.h:g' \
		CMakeModules/FindLibproj4.cmake src/math_utl.hpp || die
	# gentoo: avoid install files in datadir directory
	sed -i \
		-e '/AUTHORS/d' \
		CMakeLists.txt || die

	if use python; then
		local abi
		for abi in ${PYTHON_ABIS}; do
			mkdir "${S}"-${abi}
		done
	fi
}

src_configure() {
	# MPI is still very buggy
	mycmakeargs+=(
		-DMPICH=OFF
		-DBUNDLED_ANTLR=OFF
		-DGDL_DATA_DIR=share/gdl/pro/gdl
		$(cmake-utils_use fftw)
		$(cmake-utils_use grib)
		$(cmake-utils_use gshhs)
		$(cmake-utils_use hdf)
		$(cmake-utils_use hdf5)
		$(cmake-utils_use imagemagick MAGICK)
		$(cmake-utils_use netcdf)
		$(cmake-utils_use openmp)
		$(cmake-utils_use proj LIBPROJ4)
		$(cmake-utils_use ps PSLIB)
		$(cmake-utils_use udunits)
		$(cmake-utils_use wxwidgets)
		$(cmake-utils_use X X11)
	)
	configuration() {
		mycmakeargs+=( $@ )
		CMAKE_BUILD_DIR="${BUILDDIR:-${S}_build}" cmake-utils_src_configure
	}
	configuration -DPYTHON_MODULE=OFF -DPYTHON=OFF
	use python && \
		python_execute_function -s configuration -DPYTHON_MODULE=ON -DPYTHON=ON
}

src_compile() {
	cmake-utils_src_compile
	use python && python_src_compile
}

src_test() {
	# defines a check target instead of the ctest to define some LDPATH
	if use X; then
		Xemake -j1 -C ${CMAKE_BUILD_DIR} check
	else
		emake -j1 -C ${CMAKE_BUILD_DIR} check
	fi
}

src_install() {
	cmake-utils_src_install
	if use python; then
		installation() {
			exeinto $(python_get_sitedir)
			newexe "${S}"-${PYTHON_ABI}/src/libgdl.so GDL.so
		}
		python_execute_function -s installation
		dodoc PYTHON.txt
	fi
	echo "GDL_PATH=\"+${EPREFIX}/usr/share/gdl/pro\"" > 50gdl
	doenvd 50gdl
}
