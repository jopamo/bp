# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=pdm-backend
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Color names and value formats defined by the HTML and CSS specifications"
HOMEPAGE="
	https://github.com/ubernostrum/webcolors/
	https://pypi.org/project/webcolors/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
