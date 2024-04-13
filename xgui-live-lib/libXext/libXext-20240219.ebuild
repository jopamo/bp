# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xext library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=424b67ad03fafdb0d6caf2e9bf5a103e9717e71f
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXext/-/archive/${SNAPSHOT}/libXext-${SNAPSHOT}.tar.bz2 -> libXext-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxext-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="doc static-libs"

DEPEND=">=xgui-live-lib/libX11-1.6.2:=
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
		$(use_enable doc specs)
		$(use_with doc xmlto)
		--without-fop
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
