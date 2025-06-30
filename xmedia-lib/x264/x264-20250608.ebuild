# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="A free library for encoding X264/AVC streams"
HOMEPAGE="https://www.videolan.org/developers/x264.html"

SNAPSHOT=b35605ace3ddf7c1a5d67a2eb553f034aef41d55
SRC_URI="https://code.videolan.org/videolan/x264/-/archive/${SNAPSHOT}/x264-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/x264-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="interlaced opencl static-libs pic ffmpeg lsmash ffmpegsource"

DEPEND="
	app-lang/nasm
	opencl? ( app-lang/perl )
	ffmpeg? ( xmedia-app/ffmpeg )
	lsmash? ( xmedia-lib/l-smash )
	ffmpegsource? ( xmedia-lib/ffmpegsource )
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
		--enable-shared \
		--host="${CHOST}" \
		$(usex ffmpeg "" "--disable-lavf") \
		$(usex ffmpeg "" "--disable-swscale") \
		$(usex ffmpegsource "" "--disable-ffms") \
		$(usex interlaced "" "--disable-interlaced") \
		$(usex lsmash "" "--disable-lsmash") \
		$(usex opencl "" "--disable-opencl") \
		$(usex pic "--enable-pic" "") \
		$(usex static-libs "--enable-static" "") || die
}
