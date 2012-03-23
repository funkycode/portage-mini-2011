# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_BDEPEND="<<>>"
PYTHON_DEPEND="python? ( <<>> )"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.* *-jython *-pypy-*"

inherit multilib python toolchain-funcs

MY_PN="Botan"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A C++ crypto library"
HOMEPAGE="http://botan.randombit.net/"
SRC_URI="http://files.randombit.net/botan/${MY_P}.tbz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~ppc-macos"
IUSE="bzip2 doc gmp python ssl threads zlib"

RDEPEND="bzip2? ( >=app-arch/bzip2-1.0.5 )
	gmp? ( >=dev-libs/gmp-4.2.2 )
	python? ( <dev-libs/boost-1.48[python] )
	ssl? ( >=dev-libs/openssl-0.9.8g )
	zlib? ( >=sys-libs/zlib-1.2.3 )"
DEPEND="${RDEPEND}
	doc? ( $(python_abi_depend dev-python/sphinx) )"

S="${WORKDIR}/${MY_P}"

DOCS="readme.txt"

src_prepare() {
	sed \
		-e "s/-Wl,-soname,\$@ //" \
		-e "s/-lbotan/-lbotan-1.10/" \
		-i src/build-data/makefile/python.in || die "sed failed"
	sed \
		-e "/DOCDIR/d" \
		-e "/^install:/s/ docs//" \
		-i src/build-data/makefile/unix_shr.in || die "sed failed"
}

src_configure() {
	local disable_modules="proc_walk,unix_procs,cpu_counter"

	if ! use threads; then
		disable_modules="${disable_modules},pthreads"
	fi

	# Enable v9 instructions for sparc64
	if [[ "${PROFILE_ARCH}" = "sparc64" ]]; then
		CHOSTARCH="sparc32-v9"
	else
		CHOSTARCH="${CHOST%%-*}"
	fi

	elog "Disabling modules: ${disable_modules}"

	local os
	case ${CHOST} in
		*-darwin*)   os=darwin ;;
		*)           os=linux  ;;
	esac

	# foobared buildsystem, --prefix translates into DESTDIR, see also make
	# install in src_install, we need the correct live-system prefix here on
	# Darwin for a shared lib with correct install_name
	./configure.py \
		--prefix="${EPREFIX}/usr" \
		--libdir=$(get_libdir) \
		--docdir=share/doc \
		--cc=gcc \
		--os=${os} \
		--cpu=${CHOSTARCH} \
		--with-endian="$(tc-endian)" \
		--without-sphinx \
		--with-tr1=system \
		$(use_with bzip2) \
		$(use_with gmp gnump) \
		$(use_with python boost-python) \
		$(use_with ssl openssl) \
		$(use_with zlib) \
		--disable-modules=${disable_modules} \
		|| die "configure.py failed"
}

src_compile() {
	emake CXX="$(tc-getCXX)" AR="$(tc-getAR) crs" LIB_OPT="${CXXFLAGS}" MACH_OPT=""

	if use doc; then
		einfo "Generation of documentation"
		sphinx-build doc doc_output
	fi

	if use python; then
		python_copy_sources build/python
		rm -fr build/python

		building() {
			rm -f build/python || return 1
			ln -s python-${PYTHON_ABI} build/python || return 1
			emake -f Makefile.python \
				CXX="$(tc-getCXX)" \
				CFLAGS="${CXXFLAGS}" \
				LDFLAGS="${LDFLAGS}" \
				PYTHON_ROOT="/usr/$(get_libdir)" \
				PYTHON_INC="-I$(python_get_includedir)"
		}
		python_execute_function building
	fi
}

src_test() {
	chmod -R ugo+rX "${S}"
	emake CXX="$(tc-getCXX)" CHECK_OPT="${CXXFLAGS}" check
	LD_LIBRARY_PATH="${S}" ./check --validate || die "Validation tests failed"
}

src_install() {
	emake DESTDIR="${ED}usr" install

	if use doc; then
		pushd doc_output > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static
		popd > /dev/null
	fi

	if use python; then
		installation() {
			rm -f build/python || return 1
			ln -s python-${PYTHON_ABI} build/python || return 1
			emake -f Makefile.python \
				PYTHON_SITE_PACKAGE_DIR="${ED}$(python_get_sitedir)" \
				install
		}
		python_execute_function installation
	fi
}

pkg_postinst() {
	if use python; then
		python_mod_optimize botan
	fi
}

pkg_postrm() {
	if use python; then
		python_mod_cleanup botan
	fi
}
