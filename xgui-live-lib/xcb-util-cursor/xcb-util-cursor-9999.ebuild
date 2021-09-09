# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="X C-language Bindings sample implementations"
HOMEPAGE="https://xcb.freedesktop.org/"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/lib/libxcb-cursor.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test static-libs"

RDEPEND="xgui-live-lib/libxcb
	>=xgui-live-lib/xcb-util-image-0.3.9-r1
	>=xgui-live-lib/xcb-util-renderutil-0.3.9
	>=xgui-live-app/xcb-proto-1.8-r3:=
	xgui-live-app/xorgproto"

DEPEND="${RDEPEND}
	>=dev-util/gperf-3.0.1
	test? ( >=lib-dev/check-0.9.11 )"

src_prepare() {
	eautoreconf
	default
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
