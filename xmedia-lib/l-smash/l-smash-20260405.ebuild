# Distributed under the terms of the GNU General Public License v2

inherit toolchain-funcs qa-policy

DESCRIPTION="(FFmpeg) Libavcodec-SMASH decoder/demuxer wrapper library"
HOMEPAGE="https://github.com/l-smash/l-smash"
SNAPSHOT=04e39f1fb232c332d4b04a1043c02c7c2d282d00
SRC_URI="https://github.com/vimeo/l-smash/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug static-libs"

DEPEND="xmedia-app/ffmpeg
		xmedia-lib/obuparse"

src_prepare() {
	qa-policy-configure
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

src_install() {
	default
	qa-policy-install
}
