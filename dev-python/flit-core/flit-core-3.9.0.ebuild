# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone

inherit distutils-r1 pypi

DESCRIPTION="Simplified packaging of Python modules (core module)"
HOMEPAGE="
	https://pypi.org/project/flit_core/
	https://github.com/pypa/flit/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-python/tomli[${PYTHON_USEDEP}]
"
BDEPEND="
	test? ( dev-python/testpath[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest

src_prepare() {
	rm -r flit_core/vendor || die
	sed -i -e 's:from \.vendor ::' flit_core/*.py || die
	distutils-r1_src_prepare
}
