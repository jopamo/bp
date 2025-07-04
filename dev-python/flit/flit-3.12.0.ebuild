# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..13} pypy3 pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Simplified packaging of Python modules"
HOMEPAGE="
	https://github.com/pypa/flit/
	https://flit.readthedocs.io/
	https://pypi.org/project/flit/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-py/docutils[${PYTHON_USEDEP}]
	>=dev-python/flit-core-${PV}[${PYTHON_USEDEP}]
	dev-python/pip[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/tomli-w[${PYTHON_USEDEP}]
"
BDEPEND="
	${RDEPEND}
	sys-apps/grep
	test? (
		dev-python/responses[${PYTHON_USEDEP}]
		dev-python/testpath[${PYTHON_USEDEP}]
	)
"

EPYTEST_DESELECT=(
	# requires Internet
	tests/test_config.py::test_invalid_classifier
	# failing due to Gentoo pip patches
	tests/test_install.py::InstallTests::test_install_data_dir
	tests/test_install.py::InstallTests::test_install_module_pep621
	tests/test_install.py::InstallTests::test_symlink_data_dir
	tests/test_install.py::InstallTests::test_symlink_module_pep621
)

distutils_enable_tests pytest
distutils_enable_sphinx doc \
	dev-python/sphinxcontrib-github-alt \
	dev-python/pygments-github-lexers \
	dev-python/sphinx-rtd-theme

src_prepare() {
	# make sure system install is used
	rm -r flit_core || die
	distutils-r1_src_prepare
}
