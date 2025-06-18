# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xrender library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=01c4bb5b30bbb09921ca4042da369a60a73faefa
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
