# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X C-language Bindings sample implementations"
HOMEPAGE="https://xcb.freedesktop.org/"

SNAPSHOT=3a157762578a2e4253a7cb40d2854a3444d5a9df
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxcb-util/-/archive/${SNAPSHOT}/libxcb-util-${SNAPSHOT}.tar.bz2 -> libxcb-util-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxcb-util-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test static-libs"

RDEPEND="xgui-live-lib/libxcb
	xgui-live-app/xorgproto"

DEPEND="${RDEPEND}
	>=app-dev/gperf-3.0.1
	test? ( >=lib-live/check-0.9.11 )"

PDEPEND="
	xgui-live-lib/xcb-util-cursor
	xgui-live-lib/xcb-util-image
	xgui-live-lib/xcb-util-keysyms
	xgui-live-lib/xcb-util-renderutil
	xgui-live-lib/xcb-util-wm
"

BDEPEND="xgui-live-lib/xcb-util-m4"

src_prepare() {
	cp "${EROOT}"/usr/share/xcb-util-m4/*.m4 "${S}"/m4/ || die

	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
