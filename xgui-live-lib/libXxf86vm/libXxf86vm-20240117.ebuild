# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xxf86vm library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=546c0e93adc535dfaaa66277928887c8dc1f8e13
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxxf86vm/-/archive/${SNAPSHOT}/libxxf86vm-${SNAPSHOT}.tar.bz2 -> libxxf86vm-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxxf86vm-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND=">=xgui-live-lib/libX11-1.6.2
	>=xgui-live-lib/libXext-1.3.2
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
