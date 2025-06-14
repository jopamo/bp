# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} python3_{13,14}t pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Helper to test command-line scripts"
HOMEPAGE="
	https://pypi.org/project/scripttest/
	https://github.com/pypa/scripttest/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_tests pytest
