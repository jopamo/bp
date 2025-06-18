# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xrandr library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=8bf72e84e3cf0106532c5c7b8b30154ce48c70e0
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXrandr/-/archive/${SNAPSHOT}/libXrandr-${SNAPSHOT}.tar.bz2 -> libXrandr-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxrandr-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND=">=xgui-lib/libX11-1.6.2
	>=xgui-lib/libXext-1.3.2
	>=xgui-lib/libXrender-0.9.8
	xgui-tools/xorgproto"

src_prepare() {
	eautoreconf
	default
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
