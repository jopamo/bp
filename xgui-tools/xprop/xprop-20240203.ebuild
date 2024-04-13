# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="property displayer for X"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=400dbeda3b1e43f7815f596679bd785e7dbb7a4d
SRC_URI="https://gitlab.freedesktop.org/xorg/app/xprop/-/archive/${SNAPSHOT}/xprop-${SNAPSHOT}.tar.bz2 -> xprop-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/xprop-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="xgui-lib/libX11"
DEPEND="${RDEPEND}
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
