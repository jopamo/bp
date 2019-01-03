# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Getting image size from png/jpeg/jpeg2000/gif file"
HOMEPAGE="https://github.com/shibukawa/imagesize_py"
SRC_URI="https://files.pythonhosted.org/packages/41/f5/3cf63735d54aa9974e544aa25858d8f9670ac5b4da51020bbfc6aaade741/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="test"

DEPEND="dev-python/setuptools"
RDEPEND=""
