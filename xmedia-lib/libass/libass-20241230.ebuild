# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Library for SSA/ASS subtitles rendering"
HOMEPAGE="https://github.com/libass/libass"

SNAPSHOT=4d6e9ef3077fb279cab051cc00b216c5f08efb34
SRC_URI="https://github.com/libass/libass/archive/${SNAPSHOT}.tar.gz -> libass-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libass-${SNAPSHOT}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RDEPEND="
	fonts/fontconfig
	lib-dev/fribidi
	xgui-misc/freetype
	xgui-misc/harfbuzz[truetype]
"
BDEPEND="
	app-dev/pkgconf
	app-lang/nasm
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-require-system-font-provider
		--enable-fontconfig
		$(use_enable static-libs static)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
