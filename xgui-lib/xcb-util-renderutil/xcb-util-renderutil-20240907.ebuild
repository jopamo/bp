# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X C-language Bindings sample implementations"
HOMEPAGE="https://xcb.freedesktop.org/"

SNAPSHOT=5ad9853d6ddcac394d42dd2d4e34436b5db9da39
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxcb-render-util/-/archive/${SNAPSHOT}/libxcb-render-util-${SNAPSHOT}.tar.bz2 -> libxcb-render-util-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxcb-render-util-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test static-libs"

RDEPEND="
	xgui-lib/libxcb
	xgui-tools/xorgproto
"

DEPEND="${RDEPEND}
	>=app-dev/gperf-3.0.1
	test? ( >=lib-dev/check-0.9.11 )"

BDEPEND="xgui-lib/xcb-util-m4"

src_prepare() {
	cp "${EROOT}"/usr/share/xcb-util-m4/*.m4 "${S}"/m4/ || die

	default
	eautoreconf
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
