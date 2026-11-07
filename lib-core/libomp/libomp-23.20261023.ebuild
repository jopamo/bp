# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="release/$(ver_cut 1).x"
inherit cmake

DESCRIPTION="LLVM OpenMP runtime library"
HOMEPAGE="https://openmp.llvm.org/"
SNAPSHOT=395ba2c4d274e0d81bea69a49aba372e3743d113
SRC_URI="https://github.com/llvm/llvm-project/archive/${SNAPSHOT}.tar.gz -> llvm-project-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/llvm-project-${SNAPSHOT}/runtimes"

LICENSE="Apache-2.0-with-LLVM-exceptions"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="app-lang/python"

src_configure() {
	local mycmakeargs=(
		-DLLVM_ENABLE_RUNTIMES=openmp
		-DLLVM_DEFAULT_TARGET_TRIPLE="${CHOST}"
		-DLLVM_ENABLE_PER_TARGET_RUNTIME_DIR=OFF
		-DCMAKE_Fortran_COMPILER=
		-DLIBOMP_FORTRAN_MODULES=OFF
		-DLLVM_INCLUDE_TESTS=OFF
		-DLLVM_INCLUDE_DOCS=OFF
		-DOPENMP_ENABLE_LIBOMPTARGET=OFF
		-DOPENMP_ENABLE_OMPT_TOOLS=OFF
		-DLIBOMP_OMPT_SUPPORT=OFF
		-DLIBOMP_OMPD_SUPPORT=OFF
		-DLIBOMP_INSTALL_ALIASES=OFF
		-DLIBOMP_HEADERS_INSTALL_PATH=include
	)
	cmake_src_configure
}
