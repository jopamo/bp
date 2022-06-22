# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=manual
DISTUTILS_IN_SOURCE_BUILD=1

inherit distutils-r1

DESCRIPTION="Collection of extensions to Distutils"
HOMEPAGE="https://github.com/pypa/setuptools https://pypi.python.org/pypi/setuptools"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

PDEPEND="
	dev-python/certifi[${PYTHON_USEDEP}]
"

python_test() {
	# keep in sync with python_gen_cond_dep above!
	has "${EPYTHON}" python3.{8..10} pypy3 || continue

	distutils_install_for_testing
	local deselect=(
		# network
		'setuptools/tests/test_virtualenv.py::test_pip_upgrade_from_source[None]'
		setuptools/tests/test_distutils_adoption.py
		# TODO
		setuptools/tests/test_easy_install.py::TestSetupRequires::test_setup_requires_with_allow_hosts
	)
	[[ ${EPYTHON} == pypy3 ]] && deselect+=(
		setuptools/tests/test_develop.py::TestDevelop::test_2to3_user_mode
	)

	# test_easy_install raises a SandboxViolation due to ${HOME}/.pydistutils.cfg
	# It tries to sandbox the test in a tempdir
	HOME="${PWD}" epytest ${deselect[@]/#/--deselect } \
		-n "$(makeopts_jobs "${MAKEOPTS}" "$(get_nproc)")" \
		setuptools
}

python_install() {
	export DISTRIBUTE_DISABLE_VERSIONED_EASY_INSTALL_SCRIPT=1
	distutils-r1_python_install
}
