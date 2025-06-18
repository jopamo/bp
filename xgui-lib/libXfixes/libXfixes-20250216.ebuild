# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Xfixes library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=f50dd4df16163da731ad9f251cc98b9ccd0e7455
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
