# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1 flag-o-matic

DESCRIPTION="Foreign Function Interface for Python calling C code"
HOMEPAGE="https://cffi.readthedocs.io/ https://pypi.python.org/pypi/cffi"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

RDEPEND="
	lib-core/libffi
	dev-python/pycparser[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-util/pkgconf
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

DISTUTILS_IN_SOURCE_BUILD=1

filter-flags -Wl,-z,defs

python_test() {
	einfo "$PYTHONPATH"
	$PYTHON -c "import _cffi_backend as backend" || die
	PYTHONPATH="${PYTHONPATH}" \
	py.test -x -v \
		--ignore testing/test_zintegration.py \
		--ignore testing/embedding \
		c/ testing/ \
		|| die "Testing failed with ${EPYTHON}"
}
