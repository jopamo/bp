# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="X.Org Xrender library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=0564bce5446550c1b1681f3d8a933c20ea1455f7
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXrender/-/archive/${SNAPSHOT}/libXrender-${SNAPSHOT}.tar.bz2 -> libXrender-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxrender-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="
	xgui-lib/libX11
	xgui-tools/xorgproto
"

src_prepare() {
	default
	eautoreconf
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
