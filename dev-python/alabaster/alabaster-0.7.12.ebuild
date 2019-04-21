# Distributed under the terms of the GNU General Public License v2

EAPI=6


inherit distutils-r1

DESCRIPTION="A configurable sidebar-enabled Sphinx theme"
HOMEPAGE="https://github.com/bitprophet/alabaster"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="amd64 arm64"
SLOT="0"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
