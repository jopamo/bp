# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X C-language Bindings sample implementations"
HOMEPAGE="https://xcb.freedesktop.org/"

SNAPSHOT=5293d8b6165f23b9f7a8bcc903da0e4d7a75984c
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxcb-render-util/-/archive/${SNAPSHOT}/libxcb-render-util-${SNAPSHOT}.tar.bz2 -> libxcb-render-util-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxcb-render-util-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test static-libs"

RDEPEND="
	xgui-live-lib/libxcb
	xgui-live-app/xorgproto
"

DEPEND="${RDEPEND}
	>=app-dev/gperf-3.0.1
	test? ( >=lib-live/check-0.9.11 )"

BDEPEND="xgui-live-lib/xcb-util-m4"

src_prepare() {
	cp "${EROOT}"/usr/share/xcb-util-m4/*.m4 "${S}"/m4/ || die

	default
	eautoreconf
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
