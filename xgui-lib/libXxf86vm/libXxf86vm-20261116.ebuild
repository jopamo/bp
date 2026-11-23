# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="X.Org Xxf86vm library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=cf0c73fe2d5847eec3fb966487769f460c722cc4
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxxf86vm/-/archive/${SNAPSHOT}/libxxf86vm-${SNAPSHOT}.tar.bz2 -> libxxf86vm-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxxf86vm-${SNAPSHOT}"

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
