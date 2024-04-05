# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Low Level Virtual Machine"
HOMEPAGE="https://llvm.org/"

SNAPSHOT=2498e3a07f3df2272fec885f53f09ae13214ca38
SRC_URI="https://github.com/llvm/llvm-project/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-project-${SNAPSHOT}/llvm"

LICENSE="UoI-NCSA rc BSD public-domain"
SLOT=0
KEYWORDS="amd64"

IUSE="bolt +clang +clang-tools-extra +compiler-rt cross-project-tests debug libc
	libclc +lld lldb mlir openmp polly pstl test libunwind llvm-libgcc"

DEPEND="
	lib-core/libedit
	lib-core/libffi
	virtual/curses
	lib-core/libxml2
"

RESTRICT="!test? ( test )"

CMAKE_BUILD_TYPE=Release

src_configure() {
	LLVM_PROJECTS="llvm"
	LLVM_ENABLE_RUNTIMES="libcxx;libcxxabi"

	use libc && LLVM_ENABLE_RUNTIMES+=";libc"
	use libunwind && LLVM_ENABLE_RUNTIMES+=";libunwind"
	use pstl && LLVM_ENABLE_RUNTIMES+=";pstl"
	use compiler-rt && LLVM_ENABLE_RUNTIMES+=";compiler-rt"
	use openmp && LLVM_ENABLE_RUNTIMES+=";openmp"
	use llvm-libgcc && LLVM_ENABLE_RUNTIMES+=";llvm-libgcc"

	use bolt && LLVM_PROJECTS+=";bolt"
	use clang && LLVM_PROJECTS+=";clang"
	use clang-tools-extra && LLVM_PROJECTS+=";clang-tools-extra"
	use compiler-rt && LLVM_PROJECTS+=";compiler-rt"
	use cross-project-tests && LLVM_PROJECTS+=";cross-project-tests"
	use libc && LLVM_PROJECTS+=";libc"
	use libclc && LLVM_PROJECTS+=";libclc"
	use lld && LLVM_PROJECTS+=";lld"
	use lldb && LLVM_PROJECTS+=";lldb"
	use mlir && LLVM_PROJECTS+=";mlir"
	use openmp && LLVM_PROJECTS+=";openmp"
	use polly && LLVM_PROJECTS+=";polly"
	use pstl && LLVM_PROJECTS+=";pstl"

	filter-flags -flto*
	filter-flags -D_FORTIFY_SOURCE*
	filter-flags -Wl,-z,defs
	filter-flags -fstack-protector-strong
	filter-flags -fassociative-math
	filter-flags -fno-semantic-interposition

	local mycmakeargs=(
		-DLLVM_ENABLE_PROJECTS="${LLVM_PROJECTS}"
		-DLLVM_APPEND_VC_REV=OFF
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DLLVM_LIBDIR_SUFFIX=${libdir#lib}
		-DBUILD_SHARED_LIBS=OFF
		-DLLVM_LINK_LLVM_DYLIB=ON
		-DLLVM_TARGETS_TO_BUILD=$(usex arm64 'AArch64' 'X86')
		-DLLVM_BUILD_TESTS=$(usex test)
		-DLLVM_ENABLE_FFI=ON
		-DLLVM_ENABLE_LIBEDIT=ON
		-DLLVM_ENABLE_TERMINFO=ON
		-DLLVM_ENABLE_LIBXML2=ON
		-DLLVM_ENABLE_ASSERTIONS=$(usex debug)
		-DLLVM_ENABLE_LIBPFM=OFF
		-DLLVM_ENABLE_EH=ON
		-DLLVM_ENABLE_RTTI=ON
		-DLLVM_HOST_TRIPLE="${CHOST}"
		-DOCAMLFIND=NO
	    -DLLVM_ENABLE_RUNTIMES="all"
		-DLLVM_BUILD_DOCS=OFF
		-DLLVM_ENABLE_OCAMLDOC=OFF
		-DLLVM_ENABLE_SPHINX=OFF
		-DLLVM_ENABLE_DOXYGEN=OFF
		-DLLVM_INSTALL_UTILS=ON
		-DLLVM_BINUTILS_INCDIR="${EPREFIX}"/usr/include
	)

	use debug || local -x CPPFLAGS="${CPPFLAGS} -DNDEBUG"
	cmake_src_configure
}

src_test() {
	# respect TMPDIR!
	local -x LIT_PRESERVES_TMP=1
	cmake_src_make check
}
