# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

DESCRIPTION="Getting image size from png/jpeg/jpeg2000/gif file"
HOMEPAGE="https://github.com/shibukawa/imagesize_py"
SRC_URI="https://files.pythonhosted.org/packages/e4/9f/0452b459c8ba97e07c3cd2bd243783936a992006cf4cd1353c314a927028/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

DEPEND="dev-python/setuptools"
