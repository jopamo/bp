# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( pypy3 pypy3_11 python3_{10..13} )
inherit distutils-r1 pypi

DESCRIPTION="Pure-python utilities in the same spirit as the standard library"
HOMEPAGE="https://boltons.readthedocs.io/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_tests pytest

DOCS=( CHANGELOG.md README.md TODO.rst )

src_test() {
	# tests break with pytest-qt, django, and likely more
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1

	distutils-r1_src_test
}
