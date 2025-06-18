# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_FULLY_TESTED=( python3_{10..13} pypy3 )
PYTHON_COMPAT=( "${PYTHON_FULLY_TESTED[@]}" pypy3_11 python3_13t python3_14 python3_14t )

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
	lib-core/tzdb
"
BDEPEND="
	dev-py/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		dev-python/freezegun[${PYTHON_USEDEP}]
		$(python_gen_cond_dep '
			dev-python/hypothesis[${PYTHON_USEDEP}]
		' "${PYTHON_FULLY_TESTED[@]}")
	)
"

PATCHES=(
	"${FILESDIR}/python-dateutil-2.9.0-system-tzdata.patch"
	"${FILESDIR}/python-dateutil-2.9.0-no-pytest-cov.patch"
)

distutils_enable_tests pytest

python_prepare_all() {
	# don't install zoneinfo tarball
	sed -i '/package_data=/d' setup.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	local EPYTEST_IGNORE=()
	if ! has_version "dev-python/hypothesis[${PYTHON_USEDEP}]"; then
		EPYTEST_IGNORE+=(
			tests/property
		)
	fi

	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest
}
