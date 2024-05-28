# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit distutils-r1

DESCRIPTION="Module for determining appropriate platform-specific dirs"
HOMEPAGE="
	https://github.com/ActiveState/appdirs/
	https://pypi.org/project/appdirs/
"
SRC_URI="
	https://github.com/ActiveState/${PN}/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

python_test() {
	"${EPYTHON}" test/test_api.py -v || die "Tests fail with ${EPYTHON}"
}
