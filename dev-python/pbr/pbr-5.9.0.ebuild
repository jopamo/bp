# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

DESCRIPTION="Inject some useful and sensible default behaviors into setuptools"
HOMEPAGE="https://github.com/openstack-dev/pbr"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		>=dev-python/coverage-4.0[${PYTHON_USEDEP}]
		!~dev-python/coverage-4.4[${PYTHON_USEDEP}]
		>=dev-python/fixtures-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/subunit-0.0.18[${PYTHON_USEDEP}]
		>=dev-python/sphinx-1.5.1[${PYTHON_USEDEP}]
		>=dev-python/six-1.9.0[${PYTHON_USEDEP}]
		>=dev-python/testrepository-0.0.18[${PYTHON_USEDEP}]
		>=dev-python/testresources-0.2.4[${PYTHON_USEDEP}]
		>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
		>=dev-python/testtools-1.4.0[${PYTHON_USEDEP}]
		>=dev-python/virtualenv-13.1.0[${PYTHON_USEDEP}]
		dev-python/wheel[${PYTHON_USEDEP}]
		dev-python/docutils[${PYTHON_USEDEP}]
		app-core/git
	)"
PDEPEND=""

# This normally actually belongs here.
python_prepare_all() {
	# This test passes when run within the source and doesn't represent a failure, but rather
	# a gentoo sandbox constraint
	# Rm tests that rely upon the package being already installed and fail
	sed -e s':test_console_script_develop:_&:' \
		-e s':test_console_script_install:_&:' \
		-e s':test_sdist_extra_files:_&:' \
		-e s':test_command_hooks:_&:' \
		-e s':test_sdist_git_extra_files:_&:' \
		-i pbr/tests/test_core.py || die
	sed -e s':test_command_hooks:_&:' \
		-e s':test_global_setup_hooks:_&:' \
		-i pbr/tests/test_hooks.py || die
	rm pbr/tests/test_wsgi.py || die "couldn't remove wsgi network tests"
	einfo "rogue tests disabled"
	sed -i '/^hacking/d' test-requirements.txt || die

	distutils-r1_python_prepare_all
}

python_test() {
	distutils_install_for_testing

	rm -rf .testrepository || die "couldn't remove '.testrepository' under ${EPTYHON}"

	testr init || die "testr init failed under ${EPYTHON}"
	testr run || die "testr run failed under ${EPYTHON}"
}
