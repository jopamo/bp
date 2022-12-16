# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Reliable machine-readable Linux distribution information for Python"
HOMEPAGE="
	https://distro.readthedocs.io/en/latest/
	https://github.com/python-distro/distro/
	https://pypi.org/project/distro/
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="amd64 arm64"
