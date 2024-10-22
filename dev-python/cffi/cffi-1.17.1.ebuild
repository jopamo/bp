# Distributed under the terms of the GNU General Public License v2

# please keep this ebuild at EAPI 8 -- sys-apps/portage dep
EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
# DO NOT ADD pypy to PYTHON_COMPAT
# pypy bundles a modified version of cffi. Use python_gen_cond_dep instead.
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 toolchain-funcs pypi

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
	dev-python/pycparser[${PYTHON_USEDEP}]
	dev-py/setuptools[${PYTHON_USEDEP}]
"
BDEPEND="
	${RDEPEND}
	virtual/pkgconfig
	test? (
		dev-python/py[${PYTHON_USEDEP}]
	)
"

distutils_enable_sphinx doc/source
distutils_enable_tests pytest

PATCHES=(
	"${FILESDIR}"/cffi-1.14.0-darwin-no-brew.patch
)

src_prepare() {
	filter-flags -Wl,-z,defs
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
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest src/c testing
}
