# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=standalone

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/setuptools-scm
	dev-pypi/vcs-versioning
"
# lockstep-pypi-deps: end
DESCRIPTION="Manage versions by scm tags via setuptools"
HOMEPAGE="https://github.com/pypa/setuptools-scm/"
SNAPSHOT=efa2c855307ff1ae4b4e176e53cd5175a2b13f2f
SRC_URI="https://github.com/pypa/setuptools-scm/archive/${SNAPSHOT}.tar.gz -> setuptools-scm-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/setuptools-scm-${SNAPSHOT}/setuptools-scm"

# Upstream no longer ships VCS metadata in the archive that this snapshot uses.
# Force a deterministic project version for wheel generation.
export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"


LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# there's an optional dep on rich for cute logs
RDEPEND="
	dev-py/vcs-versioning[${PYTHON_USEDEP}]
	dev-pypi/packaging[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		dev-pypi/tomli[${PYTHON_USEDEP}]
		dev-pypi/typing-extensions[${PYTHON_USEDEP}]
	' 3.10)
"
BDEPEND="
	dev-py/vcs-versioning[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-pypi/build[${PYTHON_USEDEP}]
		dev-pypi/typing-extensions[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	local EPYTEST_DESELECT=(
		# fetching from the Internet
		testing_scm/test_regressions.py::test_pip_download

		# calls flake8, unpredictable
		testing_scm/test_functions.py::test_dump_version_flake8
	)

	if has_version dev-py/nose; then
		EPYTEST_DESELECT+=(
			# https://bugs.gentoo.org/892639
			testing_scm/test_integration.py::test_pyproject_support
		)
	fi

	epytest
}
