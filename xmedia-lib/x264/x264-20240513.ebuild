# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="A free library for encoding X264/AVC streams"
HOMEPAGE="https://www.videolan.org/developers/x264.html"

SNAPSHOT=4613ac3c15fd75cebc4b9f65b7fb95e70a3acce1
SRC_URI="https://code.videolan.org/videolan/x264/-/archive/${SNAPSHOT}/x264-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/x264-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+interlaced opencl static-libs pic"

DEPEND="
	app-lang/nasm
	opencl? ( app-lang/perl )
	xmedia-app/ffmpeg
	xmedia-lib/l-smash
	xmedia-lib/ffmpegsource
"

RESTRICT="test"

append-flags -ffat-lto-objects

src_configure() {
	tc-export CC

	"${S}/configure" \
		--prefix="${EPREFIX}"/usr \
		--libdir="${EPREFIX}"/usr/lib \
		--disable-avs \
		--disable-gpac \
		$(usex pic "--enable-pic" "") \
		--enable-shared \
		--host="${CHOST}" \
		$(usex interlaced "" "--disable-interlaced") \
		$(usex opencl "" "--disable-opencl") \
		$(usex static-libs "--enable-static" "") || die
}
