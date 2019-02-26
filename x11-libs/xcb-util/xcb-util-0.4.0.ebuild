# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="X C-language Bindings sample implementations"
HOMEPAGE="https://xcb.freedesktop.org/"
SRC_URI="https://www.x.org/archive/individual/xcb/${P}.tar.bz2"
SLOT=0

KEYWORDS="amd64 arm64"
IUSE="test static-libs doc"

RDEPEND=">=x11-libs/libxcb-1.9.1:=
	x11/xorgproto"

DEPEND="${RDEPEND}
	>=dev-util/gperf-3.0.1
	test? ( >=lib-dev/check-0.9.11 )"

PDEPEND="
	>=x11-libs/xcb-util-cursor-0.1.1:=
	>=x11-libs/xcb-util-image-${PV}:=
	>=x11-libs/xcb-util-keysyms-${PV}:=
	>=x11-libs/xcb-util-renderutil-0.3.9:=
	>=x11-libs/xcb-util-wm-${PV}:=
"

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_with doc doxygen)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
