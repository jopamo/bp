# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone

inherit distutils-r1

DESCRIPTION="Manage versions by scm tags via setuptools"
HOMEPAGE="
	https://github.com/pypa/setuptools-scm/
	https://pypi.org/project/setuptools-scm/
"

SNAPSHOT=0b14913638eca665266f3a49124a31ba78283a89
SRC_URI="https://github.com/pypa/setuptools-scm/archive/${SNAPSHOT}.tar.gz -> setuptools-scm-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/setuptools-scm-${SNAPSHOT}"


LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# there's an optional dep on rich for cute logs
RDEPEND="
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-py/setuptools[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		dev-python/tomli[${PYTHON_USEDEP}]
	' 3.10)
"
BDEPEND="
	dev-py/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/build[${PYTHON_USEDEP}]
		dev-python/typing-extensions[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	local EPYTEST_DESELECT=(
		# the usual nondescript gpg-agent failure
		testing/test_git.py::test_git_getdate_signed_commit

		# fetching from the Internet
		testing/test_regressions.py::test_pip_download

		# calls flake8, unpredictable
		testing/test_functions.py::test_dump_version_flake8
	)

	if has_version dev-python/nose; then
		EPYTEST_DESELECT+=(
			# https://bugs.gentoo.org/892639
			testing/test_integration.py::test_pyproject_support
		)
	fi

	epytest
}
