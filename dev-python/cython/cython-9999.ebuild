# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1 flag-o-matic toolchain-funcs git-r3

DESCRIPTION="A Python to C compiler"
HOMEPAGE="http://cython.org https://pypi.python.org/pypi/Cython"
EGIT_REPO_URI="https://github.com/cython/cython.git"

LICENSE="Apache-2.0"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="test"

DEPEND=">=dev-python/setuptools-9.1[${PYTHON_USEDEP}]
	test? ( dev-python/numpy[${PYTHON_USEDEP}] )"

SITEFILE=50cython-gentoo.el

python_compile() {
	if ! python_is_python3; then
		local CFLAGS="${CFLAGS}"
		local CXXFLAGS="${CXXFLAGS}"
		append-flags -fno-strict-aliasing
	fi

	# Python gets confused when it is in sys.path before build.
	local PYTHONPATH=""
	export PYTHONPATH

	distutils-r1_python_compile
}

python_test() {
	tc-export CC
	"${PYTHON}" runtests.py -vv --work-dir "${BUILD_DIR}"/tests \
		|| die "Tests fail with ${EPYTHON}"
}
