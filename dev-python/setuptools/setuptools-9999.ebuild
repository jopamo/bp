# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

DESCRIPTION="Collection of extensions to Distutils"
HOMEPAGE="https://github.com/pypa/setuptools https://pypi.python.org/pypi/setuptools"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/pypa/setuptools.git"
	inherit git-r3
else
	SRC_URI="https://github.com/pypa/setuptools/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 arm64"
fi

LICENSE="MIT"
SLOT="0"

PDEPEND="
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
"

# Force in-source build because build system modifies sources.
#DISTUTILS_IN_SOURCE_BUILD=1

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
