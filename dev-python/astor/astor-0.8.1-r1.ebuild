# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 pypy3_11 python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Read/rewrite/write Python ASTs"
HOMEPAGE="
	https://pypi.org/project/astor/
	https://github.com/berkerpeksag/astor/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

PATCHES=(
	"${FILESDIR}"/${P}-tests-bigint.patch
)

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	tests/test_rtrip.py
)
