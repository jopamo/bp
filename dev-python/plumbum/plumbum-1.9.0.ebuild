# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="A library for shell script-like programs in python"
HOMEPAGE="
	https://plumbum.readthedocs.io/en/latest/
	https://github.com/tomerfiliba/plumbum/
	https://pypi.org/project/plumbum/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	dev-python/hatch-vcs[${PYTHON_USEDEP}]
	test? (
		dev-python/psutil[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/pytest-timeout[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	local EPYTEST_DESELECT=(
		# Need sshd running
		tests/test_remote.py
		tests/test_utils.py
		# Windows specific
		tests/test_putty.py
		# Needs sudo without password
		tests/test_sudo.py
		# Wrong assumptions about env handling
		tests/test_env.py::TestEnv::test_change_env
		tests/test_env.py::TestEnv::test_dictlike
		tests/test_local.py::TestLocalPath::test_iterdir
	)

	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest -o addopts= -p pytest_mock -p timeout
}

pkg_postinst() {
 "remote commands via ssh" dev-python/paramiko
 "progress bars in jupyter" dev-python/ipywidgets
 "colored output in jupyter" dev-python/ipython
 "images on the command line" xgui-app/pillow
}
