# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xlib-based client API for the XTEST & RECORD extensions library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=c542acce77be47156e53b74f5f9ca7156b3de7f5
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXtst/-/archive/${SNAPSHOT}/libXtst-${SNAPSHOT}.tar.bz2 -> libXtst-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxtst-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND=">=xgui-live-lib/libX11-1.6.2
	>=xgui-live-lib/libXext-1.3.2
	>=xgui-live-lib/libXi-1.7.2
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
