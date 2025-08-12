# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xext library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=a43b0df438b1cfb6516695aac4dad2436c0b4c60
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXext/-/archive/${SNAPSHOT}/libXext-${SNAPSHOT}.tar.bz2 -> libXext-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxext-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="doc static-libs"

DEPEND=">=xgui-lib/libX11-1.6.2:=
	xgui-tools/xorgproto"

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
