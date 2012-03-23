# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="2.5"

inherit distutils

DESCRIPTION="SPF (Sender Policy Framework) implemented in Python."
HOMEPAGE="http://pypi.python.org/pypi/pyspf"
SRC_URI="mirror://sourceforge/pymilter/${P}.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="$(python_abi_depend dev-python/authres)
	$(python_abi_depend -i "2.*" dev-python/pydns:2)
	$(python_abi_depend -i "3.*" dev-python/pydns:3)"
RDEPEND="${DEPEND}"

PYTHON_MODULES="spf.py"

src_prepare() {
	distutils_src_prepare

	# Fix compatibility with Python 3.
	sed \
		-e "s/return \[''.join(s.decode(\"ascii\") for s in a)/return \[''.join((s.decode(\"ascii\") if isinstance(s, bytes) else s) for s in a)/" \
		-e "s/print q.check(),q.mechanism/print(q.check(),q.mechanism)/" \
		-e "s/print q.perm_error.ext/print(q.perm_error.ext)/" \
		-i spf.py
}

src_test() {
	cd test

	testing() {
		python_execute PYTHONPATH="../build-${PYTHON_ABI}/lib" "$(PYTHON)" testspf.py
	}
	python_execute_function testing
}
