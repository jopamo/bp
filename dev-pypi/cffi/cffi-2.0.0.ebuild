# Distributed under the terms of the GNU General Public License v2


DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
# DO NOT ADD pypy to PYTHON_COMPAT
# pypy bundles a modified version of cffi. Use python_gen_cond_dep instead.
PYTHON_COMPAT=( python3_{11..14} python3_14t )

inherit distutils-r1 toolchain-funcs pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/pycparser
"
# lockstep-pypi-deps: end
DESCRIPTION="Foreign Function Interface for Python calling C code"
HOMEPAGE="
	https://cffi.readthedocs.io/
	https://pypi.org/project/cffi/
"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

# Needs recent libffi for HPPA fixes
DEPEND="
	>=lib-core/libffi-3.4.4-r1:=
"
# setuptools as a modern distutils provider
RDEPEND="
	${DEPEND}
	dev-pypi/pycparser[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
BDEPEND="
	${RDEPEND}
	app-dev/pkgconf
	test? (
		dev-pypi/py[${PYTHON_USEDEP}]
	)
"

distutils_enable_sphinx doc/source
EPYTEST_PLUGINS=()
# xdist fails to collect the tests
distutils_enable_tests pytest

PATCHES=(
	"${FILESDIR}"/cffi-1.14.0-darwin-no-brew.patch
	"${FILESDIR}"/${P}-pycparser-tests.patch
)

src_prepare() {
	if [[ ${CHOST} == *darwin* ]] ; then
		# Don't obsessively try to find libffi
		sed -i -e "s/.*\-iwithsysroot\/usr\/include\/ffi.*/\tpass/" setup.py || die
	fi
	distutils-r1_src_prepare
}

src_configure() {
	tc-export PKG_CONFIG
}

python_test() {
	local EPYTEST_IGNORE=(
		# these tests call pip
		testing/cffi0/test_zintegration.py
	)

	"${EPYTHON}" -c "import _cffi_backend as backend" || die
	epytest src/c testing
}
src_prepare() {
    default
    filter-flags -Wl,-z,defs
}
