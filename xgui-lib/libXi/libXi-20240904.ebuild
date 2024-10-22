# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xi library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=3c2d5aedd7708c75710b39268631762de904c304
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXi/-/archive/${SNAPSHOT}/libXi-${SNAPSHOT}.tar.bz2 -> libXi-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxi-${SNAPSHOT}"

KEYWORDS="amd64 arm64"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="doc static-libs"

DEPEND=">=xgui-lib/libX11-1.6.2
	>=xgui-lib/libXext-1.3.2
	>=xgui-lib/libXfixes-5.0.1
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
