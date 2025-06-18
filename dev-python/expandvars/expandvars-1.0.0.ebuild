# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( pypy3_11 python3_{11..14} python3_{13,14}t )

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
