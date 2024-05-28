# Distributed under the terms of the GNU General Public License v2

# please keep this ebuild at EAPI 7 -- sys-apps/portage dep
EAPI=7

DISTUTILS_USE_PEP517=flit
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="A mutable set that remembers the order of its entries"
HOMEPAGE="https://github.com/rspeer/ordered-set"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_tests pytest
