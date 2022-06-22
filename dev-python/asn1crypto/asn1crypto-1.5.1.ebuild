# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

DESCRIPTION="Python ASN.1 library with a focus on performance and a pythonic API"
HOMEPAGE="https://github.com/wbond/asn1crypto/ https://pypi.python.org/pypi/asn1crypto/"
# pypi tarball does not have tests
SRC_URI="https://github.com/wbond/asn1crypto/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	esetup.py test
}
