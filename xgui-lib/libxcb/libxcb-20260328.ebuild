# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="X C-language Bindings library"
HOMEPAGE="https://xcb.freedesktop.org/"
SNAPSHOT=4d6e1c8fffaf811cf4d0e68ff3bc6f50e62c32c7
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxcb/-/archive/${SNAPSHOT}/libxcb-${SNAPSHOT}.tar.bz2 -> libxcb-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxcb-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="keep-la test xkb static-libs"

DEPEND="
	xgui-lib/libXau
	xgui-lib/libXdmcp
	test? ( lib-dev/check )
	lib-core/libxslt
	xgui-tools/xcb-proto
"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	qa-policy-configure
	local myconf=(
		--disable-devel-docs
		$(use_enable xkb)
		--enable-xinput
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	qa-policy-install
	use static-libs || find "${ED}" -name '*.a' -delete

	if ! use keep-la; then
		find "${ED}" -name '*.la' -delete || die
	fi
}
