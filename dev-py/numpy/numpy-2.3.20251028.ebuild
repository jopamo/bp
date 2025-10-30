# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="maintenance/$(ver_cut 1-2).x"

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=meson-python

inherit distutils-r1 flag-o-matic 

DESCRIPTION="Fast array and numerical python library"
HOMEPAGE="
	https://numpy.org/
	https://github.com/numpy/numpy/
	https://pypi.org/project/numpy/
"

SNAPSHOT=bf272f83e63679da1cb35afab17e4443fda73b7f
SRC_URI="https://github.com/numpy/numpy/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0/2"
#KEYWORDS="amd64 arm64"

IUSE="+cpudetection index64 +lapack"

# minimal arch flags for the two supported arches
ARM64_FLAGS=( asimd )
X86_64_FLAGS=( sse sse2 )
IUSE+="
	${ARM64_FLAGS[*]/#/cpu_flags_arm_}
	${X86_64_FLAGS[*]/#/cpu_flags_x86_}
"

# uses your ILP64 LAPACK which ships *64.pc and CBLAS headers
RDEPEND="
	lapack? ( lib-dev/lapack )
"
BDEPEND="
	${RDEPEND}
	>=app-dev/meson-1.5.2
	>=dev-py/cython-3.0.6[${PYTHON_USEDEP}]
	lapack? ( app-dev/pkgconf )
	test? (
		$(python_gen_cond_dep '
			>=dev-python/cffi-1.14.0[${PYTHON_USEDEP}]
		' 'python*')
		dev-python/charset-normalizer[${PYTHON_USEDEP}]
		>=dev-python/pytz-2019.3[${PYTHON_USEDEP}]
	)
"

QA_CONFIG_IMPL_DECL_SKIP=( vrndq_f32 )

EPYTEST_PLUGINS=( hypothesis pytest-timeout )
EPYTEST_XDIST=1
distutils_enable_tests pytest

PATCHES=(
	"${FILESDIR}"/${PN}-2.3.2-no-detect.patch
	"${FILESDIR}"/${PN}-2.3.2-arm-asimddp.patch
)

# tiny baseline per supported arch
_numpy_baseline() {
	case ${ARCH} in
		amd64) echo "SSE SSE2" ;;
		arm64) echo "ASIMD" ;;
		*)     echo "MIN" ;;
	esac
}

python_configure_all() {
	filter-flags -Wl,-z,defs
	
	# ensure meson sees system pkg-config dirs
	local _pcpath="${EPREFIX}/usr/lib/pkgconfig:${EPREFIX}/usr/lib64/pkgconfig:${EPREFIX}/usr/share/pkgconfig"

	# pick pc names that match ILP64 layout when index64 is on
	local pc_blas pc_lapack
	if use lapack; then
		if use index64; then
			pc_blas=blas64
			pc_lapack=lapack64
		else
			pc_blas=blas
			pc_lapack=lapack
		fi
	else
		pc_blas=auto
		pc_lapack=auto
	fi

	local cpu_baseline
	cpu_baseline="$(_numpy_baseline)"

	DISTUTILS_ARGS=(
		"--pkg-config-path" "${_pcpath}"
		"--build.pkg-config-path" "${_pcpath}"

		-Dbuildtype=release
		-Dwerror=false

		-Dallow-noblas=$(usex !lapack true false)
		-Duse-ilp64=$(usex index64 true false)
		-Dblas=${pc_blas}
		-Dlapack=${pc_lapack}

		-Dcpu-baseline="${cpu_baseline}"
		-Dcpu-baseline-detect=disabled
		-Dcpu-dispatch="$(usex cpudetection 'MAX -XOP -FMA4' '')"
	)

	# avoid LTO in numpy for now
	filter-lto
	# numpy often needs this for safe aliasing
	append-flags -fno-strict-aliasing
}

python_test() {
	# keep lapack threads at 1 so pytest -n does not blow up
	local -x BLIS_NUM_THREADS=1
	local -x MKL_NUM_THREADS=1
	local -x OMP_NUM_THREADS=1
	local -x OPENBLAS_NUM_THREADS=1

	# avoid tests allocating >2 GiB per process
	local -x NPY_AVAILABLE_MEM="2 GiB"

	local EPYTEST_DESELECT=(
		numpy/lib/tests/test_io.py::TestSavezLoad::test_closing_fid
		numpy/lib/tests/test_io.py::TestSavezLoad::test_closing_zipfile_after_load
		numpy/_core/tests/test_umath_accuracy.py::TestAccuracy::test_validate_transcendentals
		numpy/typing/tests/test_typing.py
		numpy/f2py/tests/test_crackfortran.py
		numpy/f2py/tests/test_f2py2e.py::test_gh22819_cli
		numpy/f2py/tests/test_data.py::TestData{,F77}::test_crackedlines
	)

	cd "${BUILD_DIR}/install$(python_get_sitedir)" || die
	epytest
}

python_install_all() {
	local DOCS=( LICENSE.txt README.md THANKS.txt )
	distutils-r1_python_install_all
}
