# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( pypy3 pypy3_11 python3_{10..13} python3_13t )

inherit distutils-r1 pypi

DESCRIPTION="Expand system variables Unix style"
HOMEPAGE="
	https://github.com/sayanarijit/expandvars/
	https://pypi.org/project/expandvars/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_tests pytest
