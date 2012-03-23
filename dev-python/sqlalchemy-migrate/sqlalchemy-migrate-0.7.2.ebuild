# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
# Distributed under the terms of the GNU General Public License v2

EAPI="4-python"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.*"

inherit distutils

DESCRIPTION="Database schema migration for SQLAlchemy"
HOMEPAGE="http://code.google.com/p/sqlalchemy-migrate/ http://pypi.python.org/pypi/sqlalchemy-migrate"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86"
IUSE=""

DEPEND="$(python_abi_depend dev-python/decorator)
	$(python_abi_depend dev-python/setuptools)
	$(python_abi_depend ">=dev-python/sqlalchemy-0.6")
	$(python_abi_depend dev-python/tempita)"
RDEPEND="${DEPEND}"

PYTHON_MODULES="migrate"
