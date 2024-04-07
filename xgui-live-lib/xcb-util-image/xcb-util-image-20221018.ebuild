# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X C-language Bindings sample implementations"
HOMEPAGE="https://xcb.freedesktop.org/"

SNAPSHOT=525ce59fe2329d4b23fc0c52ed9dd92daac8ac2a
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxcb-image/-/archive/${SNAPSHOT}/libxcb-image-${SNAPSHOT}.tar.bz2 -> libxcb-image-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxcb-image-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test static-libs"

RDEPEND="xgui-live-lib/libxcb
	>=xgui-live-lib/xcb-util-${PV}:=
	xgui-live-app/xorgproto"
DEPEND="${RDEPEND}
	>=app-dev/gperf-3.0.1
	test? ( >=lib-live/check-0.9.11 )"

src_prepare() {
	eautoreconf
	default
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
