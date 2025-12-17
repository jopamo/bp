# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{11..14} python3_13t pypy3_11 )

inherit distutils-r1

DESCRIPTION="A list-like structure which implements collections.abc.MutableSequence"
HOMEPAGE="
	https://pypi.org/project/frozenlist/
	https://github.com/aio-libs/frozenlist/
"
SRC_URI="
	https://github.com/aio-libs/frozenlist/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="+native-extensions"

BDEPEND="
	dev-python/expandvars[${PYTHON_USEDEP}]
	dev-py/setuptools[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	native-extensions? (
		$(python_gen_cond_dep '
			dev-py/cython[${PYTHON_USEDEP}]
		' 'python*')
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_compile() {
	# pypy is not using the C extension
	if ! use native-extensions || [[ ${EPYTHON} != python* ]]; then
		local -x FROZENLIST_NO_EXTENSIONS=1
	fi

	distutils-r1_python_compile
}

python_test() {
	rm -rf frozenlist || die
	epytest -o addopts=
}
src_prepare() {
    default
    filter-flags -Wl,-z,defs
}
