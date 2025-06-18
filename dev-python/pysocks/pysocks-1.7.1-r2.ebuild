# Distributed under the terms of the GNU General Public License v2

# please keep this ebuild at EAPI 8 -- sys-apps/portage dep
EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYPI_PN=PySocks
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="SOCKS client module"
HOMEPAGE="
	https://github.com/Anorov/PySocks/
	https://pypi.org/project/PySocks/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

# tests are broken beyond repair and the package is no longer maintained
RESTRICT="test"
