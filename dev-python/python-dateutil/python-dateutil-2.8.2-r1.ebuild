# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="Extensions to the standard Python datetime module"
HOMEPAGE="
	https://dateutil.readthedocs.io/
	https://pypi.org/project/python-dateutil/
	https://github.com/dateutil/dateutil/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-python/six-1.5[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		dev-python/freezegun[${PYTHON_USEDEP}]
		dev-python/hypothesis[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	"${FILESDIR}/python-dateutil-2.8.2-system-tzdata.patch"
	"${FILESDIR}/python-dateutil-2.8.1-no-pytest-cov.patch"
)

distutils_enable_tests pytest

python_prepare_all() {
	# don't install zoneinfo tarball
	sed -i '/package_data=/d' setup.py || die

	distutils-r1_python_prepare_all
}
