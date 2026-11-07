# Distributed under the terms of the GNU General Public License v2

PYTHON_COMPAT=( python3_13 )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Python bindings for OpenGL"
HOMEPAGE="https://mcfletch.github.io/pyopengl/"
SRC_URI="https://files.pythonhosted.org/packages/6f/16/912b7225d56284859cd9a672827f18be43f8012f8b7b932bc4bd959a298e/pyopengl-3.1.10.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="xmedia-lib/libglvnd"
