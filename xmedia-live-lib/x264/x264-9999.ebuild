# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs git-r3

DESCRIPTION="A free library for encoding X264/AVC streams"
HOMEPAGE="https://www.videolan.org/developers/x264.html"
EGIT_REPO_URI="https://git.videolan.org/git/x264.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+interlaced opencl static-libs pic"

DEPEND="
	app-lang/nasm
	opencl? ( app-lang/perl )
	xmedia-live-app/ffmpeg
	xmedia-live-lib/l-smash
	xmedia-live-lib/ffmpegsource
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
