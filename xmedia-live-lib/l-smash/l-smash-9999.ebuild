# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 toolchain-funcs

DESCRIPTION="(FFmpeg) Libavcodec-SMASH decoder/demuxer wrapper library"
HOMEPAGE="https://github.com/l-smash/l-smash"
EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug static-libs"

FEATURES="-sandbox -usersandbox"

DEPEND="xmedia-live-app/ffmpeg"

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
		--destdir="${ED}"
		--includedir="${EPREFIX}"/usr/include
		--cc="$(tc-getCC)"
		--extra-cflags="${CFLAGS}"
		--extra-ldflags="${LDFLAGS}"
		--target-os="${CHOST}"
	)
	echo configure "${myconf[@]}"
	./configure "${myconf[@]}"
}
