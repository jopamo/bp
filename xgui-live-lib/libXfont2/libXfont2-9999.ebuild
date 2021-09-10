# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools flag-o-matic

DESCRIPTION="X.Org Xfont library"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/lib/libxfont.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bzip2 ipv6 truetype static-libs"

DEPEND="
	xgui-live-lib/xtrans
	xgui-live-lib/libfontenc
	lib-core/zlib
	truetype? ( xmedia-live-lib/freetype )
	bzip2? ( app-compression/bzip2 )
	xgui-live-app/xorgproto
"

append-flags -Wno-error=implicit-function-declaration

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		$(use_enable ipv6)
		$(use_with bzip2)
		$(use_enable truetype freetype)
		--without-fop
		--disable-xmlto
		--disable-devel-docs
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
