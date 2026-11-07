# Distributed under the terms of the GNU General Public License v2

PYTHON_COMPAT=( python3_13 )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="XML parsers with protections against resource exhaustion"
HOMEPAGE="https://github.com/tiran/defusedxml"
SRC_URI="https://files.pythonhosted.org/packages/0f/d5/c66da9b79e5bdb124974bfe172b4daf3c984ebd9c2a06e2b8a4dc7331c72/defusedxml-0.7.1.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="amd64 arm64"
