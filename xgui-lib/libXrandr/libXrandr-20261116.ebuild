# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="X.Org Xrandr library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=cc7082d2af97458dbb6d7e4bbda7b8884030e05f
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXrandr/-/archive/${SNAPSHOT}/libXrandr-${SNAPSHOT}.tar.bz2 -> libXrandr-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxrandr-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND=">=xgui-lib/libX11-1.6.2
	>=xgui-lib/libXext-1.3.2
	>=xgui-lib/libXrender-0.9.8
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
