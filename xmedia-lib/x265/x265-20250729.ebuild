# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Open source HEVC encoder"
HOMEPAGE="http://x265.org/"
SNAPSHOT=8f11c33acc267ba3f1d2bde60a6aa906e494cbde
SRC_URI="https://bitbucket.org/multicoreware/x265_git/get/${SNAPSHOT}.zip"
S="${WORKDIR}/multicoreware-x265_git-${SNAPSHOT:0:12}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-lang/nasm"
BDEPEND="
	app-dev/samurai
	app-dev/cmake
"

src_prepare() {
	default

	# add missing include for json11 used by HDR10+ helper
	sed -i '/^#include <limits>$/a #include <cstdint>' \
		"${S}/source/dynamicHDR10/json11/json11.cpp" || die
}

src_compile() {
	append-flags -ffat-lto-objects

	cmake -S "${S}/source" -B build-12 -G Ninja \
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr" \
		-DHIGH_BIT_DEPTH=TRUE \
		-DMAIN12=TRUE \
		-DEXPORT_C_API=FALSE \
		-DENABLE_CLI=FALSE \
		-DENABLE_SHARED=FALSE \
		-DENABLE_LIBNUMA=FALSE \
		-Wno-dev || die
	ninja -C build-12 || die

	cmake -S "${S}/source" -B build-10 -G Ninja \
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr" \
		-DHIGH_BIT_DEPTH=TRUE \
		-DEXPORT_C_API=FALSE \
		-DENABLE_CLI=FALSE \
		-DENABLE_SHARED=FALSE \
		-DENABLE_LIBNUMA=FALSE \
		-Wno-dev || die
	ninja -C build-10 || die

	cmake -S "${S}/source" -B build -G Ninja \
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr" \
		-DENABLE_SHARED=TRUE \
		-DENABLE_HDR10_PLUS=TRUE \
		-DEXTRA_LIB='x265_main10.a;x265_main12.a' \
		-DEXTRA_LINK_FLAGS='-L .' \
		-DLINKED_10BIT=TRUE \
		-DLINKED_12BIT=TRUE \
		-DENABLE_CLI=FALSE \
		-DENABLE_LIBNUMA=FALSE \
		-Wno-dev || die
	ln -sf ../build-10/libx265.a build/libx265_main10.a || die
	ln -sf ../build-12/libx265.a build/libx265_main12.a || die
	ninja -C build || die
}

src_install() {
	DESTDIR="${ED}" ninja -C build install || die
	dolib.so build/libhdr10plus.so* || die

	insinto /usr/lib/pkgconfig
	doins "${FILESDIR}/x265.pc" || die
}
