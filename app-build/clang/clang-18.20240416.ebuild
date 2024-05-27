# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Low Level Virtual Machine"
HOMEPAGE="https://llvm.org/"

SNAPSHOT=e6c3289804a67ea0bb6a86fadbe454dd93b8d855
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
	filter-flags -Wl,-z,defs
	filter-flags -fassociative-math
	filter-flags -fcf-protection=full
	filter-flags -fexceptions
	filter-flags -fgraphite-identity
	filter-flags -floop-interchange
	filter-flags -floop-parallelize-all
	filter-flags -flto*
	filter-flags -fno-math-errno
	filter-flags -fno-semantic-interposition
	filter-flags -fno-signed-zeros
	filter-flags -fno-trapping-math -fexceptions -fpie -fpic -fasynchronous-unwind-tables -fexceptions -Wl,-z,combreloc -Wl,-z,now -Wl,-z,relro
	filter-flags -fstack-protector-strong
	filter-flags -fuse-linker-plugin
    filter-flags -fgraphite-identity
    filter-flags -fipa-pta
    filter-flags -floop-nest-optimize
    filter-flags -flto*
    filter-flags -fstack-clash-protection
    filter-flags -ftree-loop-distribution

    replace-flags -O3 -O2

	local mycmakeargs=(
		-DLLVM_INCLUDE_TESTS=OFF
	)

	cmake_src_configure
}
