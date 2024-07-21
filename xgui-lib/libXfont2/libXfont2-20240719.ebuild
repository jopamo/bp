# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="X.Org Xfont library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=dbc2fbc5823e2a9fb6dc9536a1716674840da24c
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxfont/-/archive/${SNAPSHOT}/libxfont-${SNAPSHOT}.tar.bz2 -> libxfont-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxfont-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bzip2 ipv6 truetype static-libs"

DEPEND="
	xgui-lib/xtrans
	xgui-lib/libfontenc
	lib-core/zlib
	truetype? ( xgui-misc/freetype )
	bzip2? ( app-compression/bzip2 )
	xgui-tools/xorgproto
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
		--disable-devel-docs
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
