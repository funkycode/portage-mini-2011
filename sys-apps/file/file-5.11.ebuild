# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_DEPEND="python? ( <<>> )"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="*-jython"

inherit distutils eutils flag-o-matic libtool toolchain-funcs

DESCRIPTION="identify a file's format by scanning binary data for patterns"
HOMEPAGE="ftp://ftp.astron.com/pub/file/"
SRC_URI="ftp://ftp.astron.com/pub/file/${P}.tar.gz
	ftp://ftp.gw.com/mirrors/pub/unix/file/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="python static-libs zlib"

RDEPEND="zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}"

PYTHON_MODULES="magic.py"

pkg_setup() {
	use python && python_pkg_setup
}

src_prepare() {
	elibtoolize

	# dont let python README kill main README #60043
	mv python/README{,.python}
}

wd() { echo "${WORKDIR}"/build-${CHOST}; }
do_configure() {
	ECONF_SOURCE=${S}

	mkdir "$(wd)"
	pushd "$(wd)" >/dev/null

	econf "$@"

	popd >/dev/null
}
src_configure() {
	# file uses things like strndup() and wcwidth()
	append-flags -D_GNU_SOURCE

	# when cross-compiling, we need to build up our own file
	# because people often don't keep matching host/target
	# file versions #362941
	if tc-is-cross-compiler && ! ROOT=/ has_version ~${CATEGORY}/${P} ; then
		ac_cv_header_zlib_h=no \
		ac_cv_lib_z_gzopen=no \
		CHOST=${CBUILD} \
		CFLAGS=${BUILD_CFLAGS} \
		CXXFLAGS=${BUILD_CXXFLAGS} \
		CPPFLAGS=${BUILD_CPPFLAGS} \
		LDFLAGS="${BUILD_LDFLAGS} -static" \
		do_configure --disable-shared
	fi

	export ac_cv_header_zlib_h=$(usex zlib) ac_cv_lib_z_gzopen=$(usex zlib)
	do_configure $(use_enable static-libs static)
}

do_make() {
	emake -C "$(wd)" "$@"
}
src_compile() {
	if tc-is-cross-compiler && ! ROOT=/ has_version ~${CATEGORY}/${P} ; then
		CHOST=${CBUILD} do_make -C src file
		PATH=$(CHOST=${CBUILD} wd)/src:${PATH}
	fi
	do_make

	use python && cd python && distutils_src_compile
}

src_install() {
	do_make DESTDIR="${D}" install
	dodoc ChangeLog MAINT README

	use python && cd python && distutils_src_install
	use static-libs || rm -f "${ED}"/usr/lib*/libmagic.la
}

pkg_postinst() {
	use python && distutils_pkg_postinst
}

pkg_postrm() {
	use python && distutils_pkg_postrm
}
