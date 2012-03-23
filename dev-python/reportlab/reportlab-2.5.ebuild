# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.* *-jython"

inherit distutils eutils versionator

DESCRIPTION="Tools for generating printable PDF documents from any data source."
HOMEPAGE="http://www.reportlab.org/ http://pypi.python.org/pypi/reportlab"
SRC_URI="http://www.reportlab.org/ftp/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="doc examples test"

DEPEND="$(python_abi_depend dev-python/imaging)
	media-fonts/ttf-bitstream-vera
	media-libs/libart_lgpl
	sys-libs/zlib"
RDEPEND="${DEPEND}"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

src_prepare() {
	distutils_src_prepare

	sed -i \
		-e 's|/usr/lib/X11/fonts/TrueType/|/usr/share/fonts/ttf-bitstream-vera/|' \
		-e 's|/usr/local/Acrobat|/opt/Acrobat|g' \
		-e 's|%(HOME)s/fonts|%(HOME)s/.fonts|g' \
		src/reportlab/rl_config.py || die "sed failed"

	epatch "${FILESDIR}/${PN}-2.2_qa_msg.patch"

	rm -fr src/rl_addons/renderPM/libart_lgpl
	epatch "${FILESDIR}/${PN}-2.4-external_libart_lgpl.patch"
}

src_compile() {
	distutils_src_compile

	# One of tests already builds documentation.
	if use doc && ! use test; then
		cd docs
		PYTHONPATH="$(ls -d ../build-$(PYTHON -f --ABI)/lib.*)" "$(PYTHON -f)" genAll.py || die "genAll.py failed"
	fi
}

src_test() {
	testing() {
		"$(PYTHON)" setup.py tests-preinstall
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		# docs/reference/reportlab-reference.pdf is identical with docs/reportlab-reference.pdf
		rm -f docs/reference/reportlab-reference.pdf

		insinto /usr/share/doc/${PF}
		doins -r docs/*
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r demos
		insinto /usr/share/doc/${PF}/tools/pythonpoint
		doins -r tools/pythonpoint/demos
	fi
}
