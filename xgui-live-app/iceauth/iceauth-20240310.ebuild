# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="ICE authority file utility"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=14e122c85b9fba7100b1bdc11abdb9b939d59254
SRC_URI="https://gitlab.freedesktop.org/xorg/app/iceauth/-/archive/${SNAPSHOT}/iceauth-${SNAPSHOT}.tar.bz2 -> iceauth-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/iceauth-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="xgui-live-lib/libICE"
DEPEND="${RDEPEND}
	xgui-live-app/xorgproto"

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
