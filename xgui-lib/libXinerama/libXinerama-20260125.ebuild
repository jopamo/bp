# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools dot-a

DESCRIPTION="X.Org Xinerama library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=cc4ac9cf36fdf3815381b791e47a90b8aebc7e78
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
