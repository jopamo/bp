# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools flag-o-matic

DESCRIPTION="X C-language Bindings library"
HOMEPAGE="https://xcb.freedesktop.org/"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/lib/${PN}.git"

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
