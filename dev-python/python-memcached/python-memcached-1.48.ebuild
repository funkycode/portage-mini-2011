# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.*"

inherit distutils

DESCRIPTION="Pure python memcached client"
HOMEPAGE="http://www.tummy.com/Community/software/python-memcached/ http://pypi.python.org/pypi/python-memcached"
SRC_URI="ftp://ftp.tummy.com/pub/python-memcached/old-releases/${P}.tar.gz"

LICENSE="OSL-2.0"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="test"

DEPEND="$(python_abi_depend dev-python/setuptools)
	test? ( net-misc/memcached )"
RDEPEND=""

PYTHON_MODULES="memcache.py"

src_test() {
	if [[ "${EUID}" -eq 0 ]]; then
		ewarn "Skipping tests due to root permissions"
		return
	fi

	cp memcache.py test_memcache.py
	sed -e "s/11211/11219/" -i test_memcache.py

	memcached -d -l localhost -p 11219 -P "${T}/memcached.pid"

	testing() {
		python_execute PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test_memcache.py
	}
	python_execute_function testing

	kill "$(<"${T}/memcached.pid")"
}
