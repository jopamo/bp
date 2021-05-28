# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

DESCRIPTION="Stemmer algorithms generated from Snowball algorithms"
HOMEPAGE="https://github.com/shibukawa/snowball_py https://pypi.python.org/pypi/snowballstemmer/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

