# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X C-language Bindings sample implementations"
HOMEPAGE="https://xcb.freedesktop.org/"
SNAPSHOT=72e9fc14ba16f9e1830d2f35919862abc53abcf3
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxcb-keysyms/-/archive/${SNAPSHOT}/libxcb-keysyms-${SNAPSHOT}.tar.bz2 -> libxcb-keysyms-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxcb-keysyms-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test static-libs"

RDEPEND="xgui-lib/libxcb
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

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
