# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools

DESCRIPTION="Library for SSA/ASS subtitles rendering"
HOMEPAGE="https://github.com/libass/libass"
EGIT_REPO_URI="https://github.com/libass/libass.git"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RDEPEND="
	>=fonts/fontconfig-2.10.92
	>=xgui-misc/freetype-2.5.0.1:2
	>=lib-dev/fribidi-0.19.5-r1
	>=xgui-misc/harfbuzz-0.9.12[truetype]"

DEPEND="${RDEPEND}
	dev-util/pkgconf
	dev-lang/nasm"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--enable-fontconfig
		$(use_enable static-libs static)
		--disable-require-system-font-provider
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
