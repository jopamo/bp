# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Universal encoding detector"
HOMEPAGE="https://github.com/chardet/chardet https://pypi.python.org/pypi/chardet"
SRC_URI="https://github.com/chardet/chardet/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"
