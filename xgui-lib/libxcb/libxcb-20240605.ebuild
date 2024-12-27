# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="X C-language Bindings library"
HOMEPAGE="https://xcb.freedesktop.org/"

SNAPSHOT=ebea71700ff10b0624ca31647f0b4e23f6ffbc68
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxcb/-/archive/${SNAPSHOT}/libxcb-${SNAPSHOT}.tar.bz2 -> libxcb-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxcb-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="keep-la test xkb static-libs"

DEPEND="
	xgui-lib/libXau
	xgui-lib/libXdmcp
	test? ( lib-dev/check )
	lib-core/libxslt
	xgui-tools/xcb-proto
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

	if ! use keep-la; then
		find "${ED}" -name '*.la' -delete || die
	fi
}
