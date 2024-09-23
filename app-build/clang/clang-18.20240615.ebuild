# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Low Level Virtual Machine"
HOMEPAGE="https://llvm.org/"

SNAPSHOT=3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff
SRC_URI="https://github.com/llvm/llvm-project/archive/${SNAPSHOT}.tar.gz -> llvm-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/llvm-project-${SNAPSHOT}/${PN}"

LICENSE="UoI-NCSA rc BSD public-domain"
SLOT=0
KEYWORDS="amd64"

DEPEND="app-build/llvm"

CMAKE_BUILD_TYPE=Release

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
	filter-flags -fstack-clash-protection
	filter-flags -fstack-protector-strong
	filter-flags -ftree-loop-distribution
	filter-flags -fuse-linker-plugin

	# llvm
	filter-flags -Xclang
	filter-flags -fvectorize
	filter-flags -mllvm
	filter-flags -polly*
	filter-flags -fuse-ld=lld

    replace-flags -O3 -O2

	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DCLANG_CONFIG_FILE_SYSTEM_DIR="${EPREFIX}/etc/clang"
		-DCLANG_DEFAULT_CXX_STDLIB=libc++
		-DCLANG_LINK_CLANG_DYLIB=ON
		-DCMAKE_SKIP_RPATH=ON
		-DLLVM_TARGETS_TO_BUILD=$(usex arm64 'AArch64' 'X86')
	    -DLLVM_LINK_LLVM_DYLIB=ON
    	-DCLANG_DEFAULT_PIE_ON_LINUX=ON
    	-DCLANG_DEFAULT_RTLIB=compiler-rt
    	-DCLANG_LINK_CLANG_DYLIB=ON
    	-DENABLE_LINKER_BUILD_ID=ON
    	-DLLVM_BUILD_DOCS=OFF
    	-DLLVM_ENABLE_RTTI=ON
    	-DLLVM_ENABLE_SPHINX=ON
    	-DLLVM_INCLUDE_DOCS=OFF
    	-DLLVM_INCLUDE_TESTS=OFF
    	-DSPHINX_WARNINGS_AS_ERRORS=OFF
	)

	cmake_src_configure
}
