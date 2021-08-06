# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 flag-o-matic

DESCRIPTION="Open source HEVC encoder"
HOMEPAGE="http://x265.org/"
EGIT_REPO_URI="https://bitbucket.org/multicoreware/x265_git.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="dev-lang/nasm"
BDEPEND="
	dev-util/ninja
	dev-util/cmake
"

append-flags -ffat-lto-objects

src_compile() {
	cmake -S ${S}/source -B build-12 -G Ninja \
    -DCMAKE_INSTALL_PREFIX="${EPREFIX}"/usr \
    -DHIGH_BIT_DEPTH=TRUE \
    -DMAIN12=TRUE \
    -DEXPORT_C_API=FALSE \
    -DENABLE_CLI=FALSE \
    -DENABLE_SHARED=FALSE \
    -DENABLE_LIBNUMA=FALSE \
    -Wno-dev
  ninja -C build-12

  cmake -S ${S}/source -B build-10 -G Ninja \
    -DCMAKE_INSTALL_PREFIX="${EPREFIX}"/usr \
    -DHIGH_BIT_DEPTH=TRUE \
    -DEXPORT_C_API=FALSE \
    -DENABLE_CLI=FALSE \
    -DENABLE_SHARED=FALSE \
    -DENABLE_LIBNUMA=FALSE \
    -Wno-dev
  ninja -C build-10

  cmake -S ${S}/source -B build -G Ninja \
    -DCMAKE_INSTALL_PREFIX="${EPREFIX}"/usr \
    -DENABLE_SHARED=TRUE \
    -DENABLE_HDR10_PLUS=TRUE \
    -DEXTRA_LIB='x265_main10.a;x265_main12.a' \
    -DEXTRA_LINK_FLAGS='-L .' \
    -DLINKED_10BIT=TRUE \
    -DLINKED_12BIT=TRUE \
    -DENABLE_CLI=FALSE \
    -DENABLE_LIBNUMA=FALSE \
    -Wno-dev
  ln -s ../build-10/libx265.a build/libx265_main10.a
  ln -s ../build-12/libx265.a build/libx265_main12.a
  ninja -C build
}

src_install() {
	DESTDIR="${ED}" ninja -C build install
	dolib.so build/libhdr10plus.so*
	dolib.so build/libx265.so*

	insinto /usr/lib/pkgconfig
	doins "${FILESDIR}/${PN}.pc"
}

