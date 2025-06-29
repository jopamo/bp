# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYPI_PN="MarkupSafe"
PYTHON_COMPAT=( python3_{11..14} python3_{13,14}t pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Implements a XML/HTML/XHTML Markup safe string for Python"
HOMEPAGE="
	https://palletsprojects.com/p/markupsafe/
	https://github.com/pallets/markupsafe/
	https://pypi.org/project/MarkupSafe/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="native-extensions"

distutils_enable_tests pytest

src_prepare() {
	filter-flags -Wl,-z,defs
	distutils-r1_src_prepare

	if ! use native-extensions; then
		sed -i -e '/run_setup/s:True:False:' setup.py || die
	fi
}

python_compile() {
	filter-flags -Wl,-z,defs
	local -x CIBUILDWHEEL=1
	distutils-r1_python_compile
}

python_test() {
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest
}
