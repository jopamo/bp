# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal git-r3

DESCRIPTION="(FFmpeg) Libavcodec-SMASH decoder/demuxer wrapper library"
HOMEPAGE="https://github.com/l-smash/l-smash"
EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"

KEYWORDS="amd64 arm64 x86"

LICENSE="ISC"
SLOT="0"
IUSE="debug static-libs"

RDEPEND=">=app-media/ffmpeg-2.4.0:=[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	default
	sed -e 's/-O[s0]//g' -i configure
	multilib_copy_sources
}

multilib_src_configure()
{
	chmod +x configure
	local myeconfargs=(
		${EXTRA_LSMASH_CONF}
		$(usex debug '--enable-debug' '')
		$(usex static-libs '' '--disable-static --enable-shared')
		--prefix=/usr
		--libdir="/usr/$(get_libdir)"
		--destdir="${ED}"
		--includedir=/usr/include
		--cc="$(tc-getCC)"
		--extra-cflags="${CFLAGS}"
		--extra-ldflags="${LDFLAGS}"
		--target-os="${CHOST}"
	)
	echo configure "${myeconfargs[@]}"
	./configure "${myeconfargs[@]}"
}
