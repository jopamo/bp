# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Low Level Virtual Machine"
HOMEPAGE="https://llvm.org/"

SNAPSHOT=3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff
SRC_URI="https://github.com/llvm/llvm-project/archive/${SNAPSHOT}.tar.gz -> llvm-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/llvm-project-${SNAPSHOT}/llvm"

LICENSE="UoI-NCSA rc BSD public-domain"
SLOT=0
KEYWORDS="amd64"

IUSE="bolt +clang cross-project-tests debug libc
	libclc +lld lldb mlir openmp polly pstl test +libunwind llvm-libgcc"

DEPEND="
	lib-core/libffi
	lib-core/libxml2
	virtual/curses
"

RESTRICT="!test? ( test )"

STAGE1_DIR="${WORKDIR}/build-stage1"
STAGE2_DIR="${WORKDIR}/build-stage2"
STAGE3_DIR="${WORKDIR}/build-stage3"

src_unpack() {
	unpack ${A}
}

src_configure() {
	filter-flags -D_FORTIFY_SOURCE*
	filter-flags -Wl,-O3
	filter-flags -Wl,-z,defs -Wl,-z,combreloc -Wl,-z,now -Wl,-z,relro
	filter-flags -fassociative-math
	filter-flags -fasynchronous-unwind-tables
	filter-flags -fcf-protection=full
	filter-flags -fdevirtualize-at-ltrans
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

	# Stage 1
	mkdir -p "${STAGE1_DIR}" || die
	cd "${STAGE1_DIR}" || die
	cmake -G Ninja \
		-DBUILD_SHARED_LIBS=OFF \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_C_COMPILER=gcc \
		-DCMAKE_CXX_COMPILER=g++ \
		-DCOMPILER_RT_BUILD_SANITIZERS=OFF \
		-DCOMPILER_RT_USE_LIBEXECINFO=OFF \
		-DLLVM_APPEND_VC_REV=OFF \
		-DLLVM_BINUTILS_INCDIR="${EPREFIX}"/usr/include \
		-DLLVM_BUILD_DOCS=OFF \
		-DLLVM_BUILD_TESTS=$(usex test) \
		-DLLVM_ENABLE_ASSERTIONS=OFF \
		-DLLVM_ENABLE_DOXYGEN=OFF \
		-DLLVM_ENABLE_EH=ON \
		-DLLVM_ENABLE_FFI=ON \
		-DLLVM_ENABLE_LIBPFM=OFF \
		-DLLVM_ENABLE_LIBXML2=ON \
		-DLLVM_ENABLE_OCAMLDOC=OFF \
		-DLLVM_ENABLE_PROJECTS="clang;compiler-rt;lld" \
		-DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind" \
		-DLLVM_ENABLE_RTTI=ON \
		-DLLVM_ENABLE_SPHINX=OFF \
		-DLLVM_ENABLE_TERMINFO=ON \
		-DLLVM_INSTALL_UTILS=ON \
		-DLLVM_LINK_LLVM_DYLIB=ON \
		-DLLVM_TARGETS_TO_BUILD=$(usex arm64 'AArch64' 'X86') \
		-DOCAMLFIND=NO \
		"${S}" || die

	cd "${STAGE1_DIR}"
	ninja || die

	# Stage 2
	mkdir -p "${STAGE2_DIR}" || die
	cd "${STAGE2_DIR}" || die
	cmake -G Ninja \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_C_COMPILER="${STAGE1_DIR}/bin/clang" \
		-DCMAKE_CXX_COMPILER="${STAGE1_DIR}/bin/clang++" \
		-DCMAKE_LINKER="${STAGE1_DIR}/bin/lld" \
		-DCMAKE_AR="${STAGE1_DIR}/bin/llvm-ar" \
		-DCMAKE_RANLIB="${STAGE1_DIR}/bin/llvm-ranlib" \
		-DLLVM_USE_LINKER="${STAGE1_DIR}/bin/lld" \
		-DBUILD_SHARED_LIBS=OFF \
		-DCOMPILER_RT_BUILD_SANITIZERS=OFF \
		-DCOMPILER_RT_USE_LIBEXECINFO=OFF \
		-DLLVM_APPEND_VC_REV=OFF \
		-DLLVM_BINUTILS_INCDIR="${EPREFIX}"/usr/include \
		-DLLVM_BUILD_DOCS=OFF \
		-DLLVM_BUILD_TESTS=$(usex test) \
		-DLLVM_DEFAULT_UNWINDLIB=libunwind \
		-DLLVM_ENABLE_ASSERTIONS=OFF \
		-DLLVM_ENABLE_DOXYGEN=OFF \
		-DLLVM_ENABLE_EH=ON \
		-DLIBUNWIND_ENABLE_SHARED=OFF \
		-DLLVM_ENABLE_FFI=ON \
		-DLLVM_ENABLE_LIBPFM=OFF \
		-DLLVM_ENABLE_LIBXML2=ON \
		-DLLVM_ENABLE_LLD=ON \
		-DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;compiler-rt;lld;polly" \
		-DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind" \
		-DLLVM_ENABLE_RTTI=ON \
		-DLLVM_ENABLE_TERMINFO=ON \
		-DLLVM_INSTALL_UTILS=ON \
		-DLLVM_LINK_LLVM_DYLIB=ON \
		-DLLVM_TARGETS_TO_BUILD=$(usex arm64 'AArch64' 'X86') \
		-DOCAMLFIND=NO \
		"${S}" || die

	cd "${STAGE2_DIR}"
	ninja || die

	# Stage 3
	mkdir -p "${STAGE3_DIR}" || die
	cd "${STAGE3_DIR}" || die
	cmake -G Ninja \
		-DBUILD_SHARED_LIBS=OFF \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_C_COMPILER="${STAGE2_DIR}/bin/clang" \
		-DCMAKE_CXX_COMPILER="${STAGE2_DIR}/bin/clang++" \
		-DCMAKE_LINKER="${STAGE2_DIR}/bin/lld" \
		-DCMAKE_AR="${STAGE2_DIR}/bin/llvm-ar" \
		-DCMAKE_RANLIB="${STAGE2_DIR}/bin/llvm-ranlib" \
		-DLLVM_USE_LINKER="${STAGE2_DIR}/bin/lld" \
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr/lib/llvm/$(ver_cut 1)" \
		-DCOMPILER_RT_BUILD_SANITIZERS=OFF \
		-DCOMPILER_RT_USE_LIBEXECINFO=OFF \
		-DLLVM_APPEND_VC_REV=OFF \
		-DLLVM_BINUTILS_INCDIR="${EPREFIX}"/usr/include \
		-DLLVM_BUILD_DOCS=OFF \
		-DLLVM_BUILD_TESTS=$(usex test) \
		-DLLVM_DEFAULT_UNWINDLIB=libunwind \
		-DLLVM_ENABLE_ASSERTIONS=OFF \
		-DLLVM_ENABLE_DOXYGEN=OFF \
		-DLLVM_ENABLE_EH=ON \
		-DLIBUNWIND_ENABLE_SHARED=OFF \
		-DLLVM_ENABLE_FFI=ON \
		-DLLVM_ENABLE_LIBPFM=OFF \
		-DLLVM_ENABLE_LIBXML2=ON \
		-DLLVM_ENABLE_LLD=ON \
		-DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;compiler-rt;lld;polly" \
		-DLLVM_ENABLE_RUNTIMES="libcxx;libcxxabi;libunwind" \
		-DLLVM_ENABLE_RTTI=ON \
		-DLLVM_ENABLE_TERMINFO=ON \
		-DLLVM_INSTALL_UTILS=ON \
		-DLLVM_LINK_LLVM_DYLIB=ON \
		-DLLVM_TARGETS_TO_BUILD=$(usex arm64 'AArch64' 'X86') \
		-DOCAMLFIND=NO \
		"${S}" || die
}

src_compile() {
	cd "${STAGE3_DIR}"
	ninja || die
}

src_install() {
	cd "${STAGE3_DIR}" || die
	DESTDIR="${D}" ninja install || die

	cat > "${T}"/99${PN} <<- EOF || die
		export PATH="/usr/lib/llvm/$(ver_cut 1)/bin:$PATH"
		export LD_LIBRARY_PATH="/usr/lib/llvm/$(ver_cut 1)/lib:$LD_LIBRARY_PATH"
		export CPLUS_INCLUDE_PATH="/usr/lib/llvm/$(ver_cut 1)/include:$CPLUS_INCLUDE_PATH"
		export MANPATH="/usr/lib/llvm/$(ver_cut 1)/share/man:$MANPATH"
	EOF
	doenvd "${T}"/99${PN}

	rm "${ED}"/usr/share/man/man1/scan-build.1.bz2
}
