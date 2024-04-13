# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X C-language Bindings sample implementations"
HOMEPAGE="https://xcb.freedesktop.org/"

SNAPSHOT=c393b71fff76fe8627d0e95c53e756615f84d7a3
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxcb-cursor/-/archive/${SNAPSHOT}/libxcb-cursor-${SNAPSHOT}.tar.bz2 -> libxcb-cursor-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxcb-cursor-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test static-libs"

RDEPEND="xgui-lib/libxcb
	>=xgui-lib/xcb-util-image-0.3.9-r1
	>=xgui-lib/xcb-util-renderutil-0.3.9
	>=xgui-tools/xcb-proto-1.8-r3:=
	xgui-tools/xorgproto"

DEPEND="${RDEPEND}
	>=app-dev/gperf-3.0.1
	test? ( >=lib-dev/check-0.9.11 )"

BDEPEND="xgui-lib/xcb-util-m4"

src_prepare() {
	cp "${EROOT}"/usr/share/xcb-util-m4/*.m4 "${S}"/m4/ || die

	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--with-cursorpath='~/.cursors:~/.icons:/usr/local/share/cursors/xorg-x11:/usr/local/share/cursors:/usr/local/share/icons:/usr/local/share/pixmaps:/usr/share/cursors/xorg-x11:/usr/share/cursors:/usr/share/pixmaps/xorg-x11:/usr/share/icons:/usr/share/pixmaps'
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
