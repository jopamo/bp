# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org X Toolkit Intrinsics library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=a938ec5ca1923759327b7b80861d8382b3686a1b
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXt/-/archive/${SNAPSHOT}/libXt-${SNAPSHOT}.tar.bz2 -> libXt-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxt-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test static-libs"

RDEPEND=">=xgui-live-lib/libX11-1.6.2
	>=xgui-live-lib/libSM-1.2.1-r1
	>=xgui-live-lib/libICE-1.0.8-r1
	xgui-live-app/xorgproto"
DEPEND="${RDEPEND}
	test? ( lib-live/glib )"

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
