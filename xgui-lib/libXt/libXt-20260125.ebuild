# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org X Toolkit Intrinsics library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=8944d7f7db91a1cdfe6ad55cf031c6b1b9801192
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXt/-/archive/${SNAPSHOT}/libXt-${SNAPSHOT}.tar.bz2 -> libXt-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxt-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test static-libs"

RDEPEND=">=xgui-lib/libX11-1.6.2
	>=xgui-lib/libSM-1.2.1-r1
	>=xgui-lib/libICE-1.0.8-r1
	xgui-tools/xorgproto"
DEPEND="${RDEPEND}
	test? ( lib-core/glib )"

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
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
