# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1

DESCRIPTION="RFC-compliant FQDN validation and manipulation for Python"
HOMEPAGE="
	https://github.com/ypcrts/fqdn/
	https://pypi.org/project/fqdn/
"
SRC_URI="
	https://github.com/ypcrts/fqdn/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_tests pytest
distutils_enable_sphinx docs
