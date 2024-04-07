# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X C-language Bindings sample implementations"
HOMEPAGE="https://xcb.freedesktop.org/"

SNAPSHOT=85e093f14b0ade2956e0a5d1c37cfde06d8b1ba6
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxcb-keysyms/-/archive/${SNAPSHOT}/libxcb-keysyms-${SNAPSHOT}.tar.bz2 -> libxcb-keysyms-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxcb-keysyms-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test static-libs"

RDEPEND="xgui-live-lib/libxcb
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
