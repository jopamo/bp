# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

DESCRIPTION="HTTP library for human beings"
HOMEPAGE="http://python-requests.org/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="socks5 +ssl"

RESTRICT="test"

RDEPEND="
	>=dev-python/certifi-2017.4.17[${PYTHON_USEDEP}]
	>=dev-python/chardet-3.0.2[${PYTHON_USEDEP}]
	>=dev-python/idna-2.5[${PYTHON_USEDEP}]
	dev-python/idna[${PYTHON_USEDEP}]
	>=dev-python/urllib3-1.21.1[${PYTHON_USEDEP}]
	socks5? ( >=dev-python/PySocks-1.5.6[${PYTHON_USEDEP}] )
	ssl? (
		 >=dev-python/cryptography-1.3.4[${PYTHON_USEDEP}]
		 >=dev-python/pyopenssl-0.14[${PYTHON_USEDEP}]
	)
"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"
