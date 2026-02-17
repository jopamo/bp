# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools dot-a

DESCRIPTION="X C-language Bindings sample implementations"
HOMEPAGE="https://xcb.freedesktop.org/"
SNAPSHOT=523cbc8af809d9525703f2fa3680d8c880fe4e9c
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxcb-util/-/archive/${SNAPSHOT}/libxcb-util-${SNAPSHOT}.tar.bz2 -> libxcb-util-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxcb-util-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test static-libs"

RDEPEND="xgui-lib/libxcb
	xgui-tools/xorgproto"

DEPEND="${RDEPEND}
	>=app-dev/gperf-3.0.1
	test? ( >=lib-dev/check-0.9.11 )"

PDEPEND="
	xgui-lib/xcb-util-cursor
	xgui-lib/xcb-util-image
	xgui-lib/xcb-util-keysyms
	xgui-lib/xcb-util-renderutil
	xgui-lib/xcb-util-wm
"

BDEPEND="xgui-lib/xcb-util-m4"

src_prepare() {
	cp "${BROOT}"/usr/share/xcb-util-m4/*.m4 "${S}"/m4/ || die

	default
	eautoreconf
}

src_configure() {
	use static-libs && lto-guarantee-fat

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
	use static-libs && strip-lto-bytecode
	use static-libs || find "${ED}" -name '*.a' -delete
}
