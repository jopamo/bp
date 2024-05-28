# Distributed under the terms of the GNU General Public License v2

# please keep this ebuild at EAPI 7 -- sys-apps/portage dep
EAPI=7

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="SOCKS client module"
HOMEPAGE="https://github.com/Anorov/PySocks https://pypi.org/project/PySocks/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

# tests are broken beyond repair and the package is no longer maintained
RESTRICT="test"
