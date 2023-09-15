# Distributed under the terms of the GNU General Public License v2

# please keep this ebuild at EAPI 7 -- sys-apps/portage dep
EAPI=7

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Manage versions by scm tags via setuptools"
HOMEPAGE="
	https://github.com/pypa/setuptools_scm/
	https://pypi.org/project/setuptools-scm/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		dev-python/tomli[${PYTHON_USEDEP}]
	' 3.{8..10})
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-vcs/git
	)
"

distutils_enable_tests pytest

python_test() {
	local EPYTEST_DESELECT=(
		# the usual nondescript gpg-agent failure
		testing/test_git.py::test_git_getdate_signed_commit

		# fetching from the Internet
		testing/test_regressions.py::test_pip_download
	)

	if has_version dev-python/nose; then
		EPYTEST_DESELECT+=(
			# https://bugs.gentoo.org/892639
			testing/test_integration.py::test_pyproject_support
		)
	fi

	epytest
}
