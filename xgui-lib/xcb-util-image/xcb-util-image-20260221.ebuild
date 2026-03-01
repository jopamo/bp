# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools dot-a

DESCRIPTION="X C-language Bindings sample implementations"
HOMEPAGE="https://xcb.freedesktop.org/"
SNAPSHOT=01ad59a77ed784d697a5cf4918bbf19762fee375
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxcb-image/-/archive/${SNAPSHOT}/libxcb-image-${SNAPSHOT}.tar.bz2 -> libxcb-image-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxcb-image-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test static-libs"

RDEPEND="xgui-lib/libxcb
	xgui-lib/xcb-util
	xgui-tools/xorgproto"
DEPEND="${RDEPEND}
	>=app-dev/gperf-3.0.1
	test? ( >=lib-dev/check-0.9.11 )"

BDEPEND="xgui-lib/xcb-util-m4"

src_prepare() {
	cp "${BROOT}"/usr/share/xcb-util-m4/*.m4 "${S}"/m4/ || die

	default
	eautoreconf
}

src_configure() {
	use static-libs && lto-guarantee-fat
	default
}

src_install() {
	default
	use static-libs && strip-lto-bytecode
	use static-libs || find "${ED}" -name '*.a' -delete
}
