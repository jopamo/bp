# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools dot-a

DESCRIPTION="X.Org Xfixes library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=55bb2d1d57d43e0595ce45393f26eb433d75a7cc
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXfixes/-/archive/${SNAPSHOT}/libXfixes-${SNAPSHOT}.tar.bz2 -> libXfixes-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxfixes-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND=">=xgui-lib/libX11-1.6.2
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
