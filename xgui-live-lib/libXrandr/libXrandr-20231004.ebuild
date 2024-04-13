# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xrandr library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=512bf0b15b5597c721ff8c61083616ca9040fa72
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXrandr/-/archive/${SNAPSHOT}/libXrandr-${SNAPSHOT}.tar.bz2 -> libXrandr-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxrandr-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND=">=xgui-live-lib/libX11-1.6.2
	>=xgui-live-lib/libXext-1.3.2
	>=xgui-live-lib/libXrender-0.9.8
	xgui-live-app/xorgproto"

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
