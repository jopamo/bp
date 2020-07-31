# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

DESCRIPTION="ReadTheDocs.org theme for Sphinx"
HOMEPAGE="https://github.com/snide/sphinx_rtd_theme/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
