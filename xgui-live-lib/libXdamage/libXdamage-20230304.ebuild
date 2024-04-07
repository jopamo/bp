# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xdamage library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=2d1aae42f0497b198f79b9e791856343d14503b1
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXdamage/-/archive/${SNAPSHOT}/libXdamage-${SNAPSHOT}.tar.bz2 -> libXdamage-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libXdamage-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND=">=xgui-live-lib/libX11-1.6.2
	>=xgui-live-lib/libXfixes-5.0.1
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
