# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="X.Org Xinerama library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=92d8f35d672537721dcd3a071d04306aa065c29b
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXinerama/-/archive/${SNAPSHOT}/libXinerama-${SNAPSHOT}.tar.bz2 -> libXinerama-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxinerama-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND=">=xgui-lib/libX11-1.6.2
	>=xgui-lib/libXext-1.3.2
	xgui-tools/xorgproto"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	qa-policy-configure
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/bin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	qa-policy-install
	use static-libs || find "${ED}" -name '*.a' -delete
}
