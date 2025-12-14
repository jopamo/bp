# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="(FFmpeg) Libavcodec-SMASH decoder/demuxer wrapper library"
HOMEPAGE="https://github.com/l-smash/l-smash"
SNAPSHOT=30270d0d8b551b36b6f46c43bd3ffe997f13e157
SRC_URI="https://github.com/vimeo/l-smash/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug static-libs"

DEPEND="xmedia-app/ffmpeg
		xmedia-lib/obuparse"

src_prepare() {
	default
	sed -e 's/-O[s0]//g' -i configure
}

src_configure()
{
	chmod +x configure
	local myconf=(
		${EXTRA_LSMASH_CONF}
		$(usex debug '--enable-debug' '')
		$(usex static-libs '' '--disable-static --enable-shared')
		--prefix="${EPREFIX}"/usr
		--libdir="${EPREFIX}"/usr/lib
		--includedir="${EPREFIX}"/usr/include
		--cc="$(tc-getCC)"
		--extra-cflags="${CFLAGS}"
		--extra-ldflags="${LDFLAGS}"
		--target-os="${CHOST}"
	)
	echo configure "${myconf[@]}"
	./configure "${myconf[@]}"
}
