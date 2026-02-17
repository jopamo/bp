# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools dot-a

DESCRIPTION="X.Org Xrender library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=f32afe9f877ae032c6bc9c27b17b7978b1b4c856
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
	use static-libs && lto-guarantee-fat

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
	use static-libs && strip-lto-bytecode
	use static-libs || find "${ED}" -name '*.a' -delete
}
