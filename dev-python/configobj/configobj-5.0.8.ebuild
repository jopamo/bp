# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Simple config file reader and writer"
HOMEPAGE="
	https://github.com/DiffSK/configobj/
	https://pypi.org/project/configobj/
"
SRC_URI="
	https://github.com/DiffSK/configobj/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-python/six[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
