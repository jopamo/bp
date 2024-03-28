# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Rapid multi-Python deployment"
HOMEPAGE="
	https://codespeak.net/execnet/
	https://github.com/pytest-dev/execnet/
	https://pypi.org/project/execnet/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	dev-python/hatch-vcs[${PYTHON_USEDEP}]
"

distutils_enable_sphinx doc
distutils_enable_tests pytest

python_test() {
	local -x PYTHONDONTWRITEBYTECODE=
	epytest testing
}
