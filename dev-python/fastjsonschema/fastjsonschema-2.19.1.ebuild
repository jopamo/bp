# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Fast JSON schema validator for Python"
HOMEPAGE="
	https://github.com/horejsek/python-fastjsonschema/
	https://pypi.org/project/fastjsonschema/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	tests/benchmarks
)

PATCHES=(
	# https://github.com/horejsek/python-fastjsonschema/pull/180
	"${FILESDIR}/${P}-pytest-8.patch"
)
