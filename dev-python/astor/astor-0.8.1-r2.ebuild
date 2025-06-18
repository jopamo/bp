# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

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
	"${FILESDIR}/${P}-tests-bigint.patch"
	# https://github.com/berkerpeksag/astor/pull/233
	"${FILESDIR}/${P}-py314.patch"
)

distutils_enable_tests pytest

python_test() {
	local EPYTEST_IGNORE=(
		tests/test_rtrip.py
	)

	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest
}
