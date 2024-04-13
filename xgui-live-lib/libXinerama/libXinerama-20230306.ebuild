# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xinerama library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=51c28095951676a5896437c4c3aa40fb1972bad2
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXinerama/-/archive/${SNAPSHOT}/libXinerama-${SNAPSHOT}.tar.bz2 -> libXinerama-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxinerama-${SNAPSHOT}"

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
