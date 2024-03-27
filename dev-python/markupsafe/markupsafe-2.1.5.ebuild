# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYPI_PN="MarkupSafe"
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Implements a XML/HTML/XHTML Markup safe string for Python"
HOMEPAGE="
	https://palletsprojects.com/p/markupsafe/
	https://github.com/pallets/markupsafe/
	https://pypi.org/project/MarkupSafe/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_tests pytest
