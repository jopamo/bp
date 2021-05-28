# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

DESCRIPTION="Python package for providing Mozilla's CA Bundle"
HOMEPAGE="http://certifi.io/ https://pypi.python.org/pypi/certifi"
SRC_URI="https://github.com/certifi/python-certifi/archive/${PV}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/python-${P}

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="dev-python/setuptools"
