# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="ANSI Color formatting for output in terminal"
HOMEPAGE="
	https://github.com/termcolor/termcolor/
	https://pypi.org/project/termcolor/
"
# rename is for avoiding conflict with dev-cpp/termcolor
SRC_URI="$(pypi_sdist_url) -> ${P}.py.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="
	dev-python/hatch-vcs[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
