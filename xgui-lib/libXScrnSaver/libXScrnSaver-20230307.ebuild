# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org XScrnSaver library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=9b4e000c6c4ae213a3e52345751d885543f17929
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libXScrnSaver/-/archive/${SNAPSHOT}/libXScrnSaver-${SNAPSHOT}.tar.bz2 -> libXScrnSaver-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxscrnsaver-${SNAPSHOT}"

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
