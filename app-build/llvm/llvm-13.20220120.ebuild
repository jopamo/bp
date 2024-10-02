# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Low Level Virtual Machine"
HOMEPAGE="https://llvm.org/"

SNAPSHOT=75e33f71c2dae584b13a7d1186ae0a038ba98838
SRC_URI="https://github.com/llvm/llvm-project/archive/${SNAPSHOT}.tar.gz -> llvm-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/llvm-project-${SNAPSHOT}/llvm"

LICENSE="UoI-NCSA rc BSD public-domain"
#SLOT="$(ver_cut 1)"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bolt cross-project-tests debug libc libclc +lld lldb mlir
	openmp polly pstl test +libunwind llvm-libgcc"

DEPEND="
	lib-core/libffi
	lib-core/libxml2
	virtual/curses
"

RESTRICT="!test? ( test )"

CMAKE_BUILD_TYPE=Release

src_configure() {
	LLVM_PROJECTS="clang;clang-tools-extra"
	LLVM_ENABLE_RUNTIMES="compiler-rt"

	use libc && LLVM_ENABLE_RUNTIMES+=";libc"
	use libunwind && LLVM_ENABLE_RUNTIMES+=";libunwind"
	use pstl && LLVM_ENABLE_RUNTIMES+=";pstl"
	use openmp && LLVM_ENABLE_RUNTIMES+=";openmp"
	use llvm-libgcc && LLVM_ENABLE_RUNTIMES+=";llvm-libgcc"

	use bolt && LLVM_PROJECTS+=";bolt"
	use cross-project-tests && LLVM_PROJECTS+=";cross-project-tests"
	use libc && LLVM_PROJECTS+=";libc"
	use libclc && LLVM_PROJECTS+=";libclc"
	use lld && LLVM_PROJECTS+=";lld"
	use lldb && LLVM_PROJECTS+=";lldb"
	use mlir && LLVM_PROJECTS+=";mlir"
	use openmp && LLVM_PROJECTS+=";openmp"
	use polly && LLVM_PROJECTS+=";polly"
	use pstl && LLVM_PROJECTS+=";pstl"

	filter-flags -D_FORTIFY_SOURCE*
	filter-flags -Wl,-O3
	filter-flags -Wl,-z,combreloc
	filter-flags -Wl,-z,defs
	filter-flags -Wl,-z,now
	filter-flags -Wl,-z,relro
	filter-flags -fassociative-math
	filter-flags -fasynchronous-unwind-tables
	filter-flags -fcf-protection=full
	filter-flags -fexceptions
	filter-flags -fgraphite-identity
	filter-flags -fipa-pta
	filter-flags -floop-interchange
	filter-flags -floop-nest-optimize
	filter-flags -floop-parallelize-all
	filter-flags -flto*
	filter-flags -fno-math-errno
	filter-flags -fno-semantic-interposition
	filter-flags -fno-signed-zeros
	filter-flags -fno-trapping-math
	filter-flags -fpie
	filter-flags -fstack-clash-protection
	filter-flags -fstack-protector-strong
	filter-flags -ftree-loop-distribution
	filter-flags -fuse-linker-plugin

	replace-flags -O3 -O2

	local mycmakeargs=(
		-DCLANG_ENABLE_BOOTSTRAP=ON
		-DBOOTSTRAP_LLVM_ENABLE_LLD=ON
		-DBOOTSTRAP_BOOTSTRAP_LLVM_ENABLE_LLD=ON
		-DCLANG_BOOTSTRAP_PASSTHROUGH="CMAKE_INSTALL_PREFIX;CMAKE_VERBOSE_MAKEFILE"
		-DLLVM_ENABLE_PROJECTS="${LLVM_PROJECTS}"
		-DLLVM_APPEND_VC_REV=OFF
		#-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr/lib/llvm/$(ver_cut 1)"
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DLLVM_LIBDIR_SUFFIX=${libdir#lib}
		-DBUILD_SHARED_LIBS=OFF
		-DLLVM_LINK_LLVM_DYLIB=ON
		-DLLVM_TARGETS_TO_BUILD=$(usex arm64 'AArch64' 'X86')
		-DLLVM_BUILD_TESTS=$(usex test)
		-DCOMPILER_RT_USE_LIBEXECINFO=OFF
		-DCOMPILER_RT_BUILD_SANITIZERS=OFF
		-DLLVM_ENABLE_FFI=ON
		-DLLVM_DEFAULT_UNWINDLIB=libunwind
		-DLLVM_ENABLE_TERMINFO=ON
		-DLLVM_ENABLE_LIBXML2=ON
		-DLLVM_ENABLE_ASSERTIONS=$(usex debug)
		-DLLVM_ENABLE_LIBPFM=OFF
		-DLLVM_ENABLE_EH=ON
		-DLLVM_ENABLE_RTTI=ON
		-DLLVM_HOST_TRIPLE="${CHOST}"
		-DOCAMLFIND=NO
		-DLLVM_BUILD_DOCS=OFF
		-DLLVM_ENABLE_OCAMLDOC=OFF
		-DCMAKE_CXX_STANDARD=17
		-DLLVM_ENABLE_SPHINX=OFF
		-DLLVM_ENABLE_DOXYGEN=OFF
		-DLLVM_INSTALL_UTILS=ON
		-DLLVM_BINUTILS_INCDIR="${EPREFIX}"/usr/include
	)

	use debug || local -x CPPFLAGS="${CPPFLAGS} -DNDEBUG"
	cmake_src_configure
}

src_test() {
	local -x LIT_PRESERVES_TMP=1
	cmake_src_make check
}
