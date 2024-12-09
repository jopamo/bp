# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Low Level Virtual Machine"
HOMEPAGE="https://llvm.org/"

if [[ ${PV} == 18* ]] ; then
	SNAPSHOT="3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff"

elif [[ ${PV} == 13* ]] ; then
	SNAPSHOT="75e33f71c2dae584b13a7d1186ae0a038ba98838"

elif [[ ${PV} == 14* ]] ; then
	SNAPSHOT="f28c006a5895fc0e329fe15fead81e37457cb1d1"

elif [[ ${PV} == 15* ]] ; then
	SNAPSHOT="8dfdcc7b7bf66834a761bd8de445840ef68e4d1a"

elif [[ ${PV} == 16* ]] ; then
	SNAPSHOT="7cbf1a2591520c2491aa35339f227775f4d3adf6"

elif [[ ${PV} == 17* ]] ; then
	SNAPSHOT="6009708b4367171ccdbf4b5905cb6a803753fe18"

elif [[ ${PV} == 12* ]] ; then
	SNAPSHOT="fed41342a82f5a3a9201819a82bf7a48313e296b"
fi

SRC_URI="https://github.com/llvm/llvm-project/archive/${SNAPSHOT}.tar.gz -> llvm-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/llvm-project-${SNAPSHOT}/${PN}"

LICENSE="UoI-NCSA rc BSD public-domain"
SLOT=0
KEYWORDS="amd64 arm64"

IUSE="test zstd"

DEPEND="
	lib-core/libffi
	lib-core/libxml2
	virtual/curses
"

CMAKE_BUILD_TYPE=Release

src_configure() {
	filter-flags -D_FORTIFY_SOURCE*
	filter-flags -Wl,-O3
	filter-flags -Wl,-z,combreloc
	filter-flags -Wl,-z,defs
	filter-flags -Wl,-z,now
	filter-flags -Wl,-z,relro
	filter-flags -fassociative-math
	filter-flags -fcf-protection=full
	filter-flags -fdevirtualize-at-ltrans
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

	use elibc_musl && append-ldflags -Wl,-z,stack-size=2097152

	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DBUILD_SHARED_LIBS=ON
		-DLLVM_INCLUDE_TESTS=$(usex test)
		-DLLVM_ENABLE_ZLIB=FORCE_ON
		-DLLVM_ENABLE_ZSTD=$(usex zstd FORCE_ON OFF)
	)
	cmake_src_configure
}