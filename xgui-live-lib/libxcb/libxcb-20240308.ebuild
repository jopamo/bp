# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="X C-language Bindings library"
HOMEPAGE="https://xcb.freedesktop.org/"

SNAPSHOT=86a478032ba93f30adbc0ce96eecd3420fdf7ed1
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxcb/-/archive/${SNAPSHOT}/libxcb-${SNAPSHOT}.tar.bz2 -> libxcb-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxcb-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test xkb static-libs"

DEPEND="
	xgui-live-lib/libXau
	xgui-live-lib/libXdmcp
	test? ( lib-live/check )
	lib-core/libxslt
	xgui-live-app/xcb-proto
"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--disable-devel-docs
		$(use_enable xkb)
		--enable-xinput
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
