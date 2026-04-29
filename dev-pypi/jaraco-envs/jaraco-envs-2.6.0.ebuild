# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYPI_PN=${PN/-/.}
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/path
	dev-pypi/tox
	dev-pypi/virtualenv
"
# lockstep-pypi-deps: end
DESCRIPTION="Classes for orchestrating Python (virtual) environments"
HOMEPAGE="
	https://github.com/jaraco/jaraco.envs/
	https://pypi.org/project/jaraco.envs/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-pypi/path[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-py/setuptools-scm[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

src_prepare() {
	# optional runtime dep, not used by anything in ::gentoo
	sed -i -e '/tox/d' setup.cfg || die
	distutils-r1_src_prepare
}

python_test() {
	epytest tests
}
