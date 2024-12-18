# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit distutils-r1

MY_P=python-${P}
DESCRIPTION="Python library to sort collections and containers"
HOMEPAGE="
	https://www.grantjenks.com/docs/sortedcontainers/
	https://github.com/grantjenks/python-sortedcontainers/
	https://pypi.org/project/sortedcontainers/
"
SRC_URI="
	https://github.com/grantjenks/python-sortedcontainers/archive/v${PV}.tar.gz
		-> ${MY_P}.gh.tar.gz
"
S=${WORKDIR}/${MY_P}

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_tests pytest

python_test() {
	epytest --ignore docs/conf.py
}